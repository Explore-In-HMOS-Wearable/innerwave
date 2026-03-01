import { wearEngine } from '@kit.WearEngine';
import { common } from '@kit.AbilityKit';
import { util } from '@kit.ArkTS';

import { TrainingModel } from '../model/TrainingModel';
import { ExerciseModel } from '../model/ExerciseModel';
import { IconConstants } from '../constants/IconConstants';

interface P2pMessageCompat {
  content?: Uint8Array | string;
  data?: Uint8Array | string;
  payload?: Uint8Array | string;
}

export interface WearEnginePhonePeerConfig {
  phoneBundleName: string;
  phoneFingerprint: string;
  transformLocal?: boolean;
}

interface ExerciseDTO {
  name?: string;
  duration?: string;
  src?: string;
}

interface TrainingDTO {
  name?: string;
  duration?: string;
  difficulty?: string;
  calories?: string;
  src?: string;
  exercises?: Array<ExerciseDTO>;
}

interface TrainingResponseDTO {
  trainings?: Array<TrainingDTO>;
  data?: Array<TrainingDTO>;
}

interface P2pAppParamCompat extends wearEngine.P2pAppParam {
  transformLocalAppInfo?: boolean;
}

export class WearEngineService {
  private static inst: WearEngineService | null = null;

  static getInstance(): WearEngineService {
    if (!WearEngineService.inst) {
      WearEngineService.inst = new WearEngineService();
    }
    return WearEngineService.inst;
  }

  private ctx: common.Context | null = null;
  private authClient: wearEngine.AuthClient | null = null;
  private deviceClient: wearEngine.DeviceClient | null = null;
  private p2pClient: wearEngine.P2pClient | null = null;

  private phoneDevice: wearEngine.Device | null = null;
  private peer: WearEnginePhonePeerConfig | null = null;

  private receiverCb: ((p2pMessage: wearEngine.P2pMessage) => void) | null = null;

  public onTextMessage: ((text: string) => void) | null = null;
  public onTrainings: ((trainings: Array<TrainingModel>) => void) | null = null;

  private isListening: boolean = false;

  private cachedAppParam: wearEngine.P2pAppParam | null = null;

  private decoder: util.TextDecoder = util.TextDecoder.create('utf-8');

  private constructor() {}

  init(context: common.Context): void {
    this.ctx = context;
    this.authClient = wearEngine.getAuthClient(context);
    this.deviceClient = wearEngine.getDeviceClient(context);
    this.p2pClient = wearEngine.getP2pClient(context);
  }

  setPhonePeerConfig(cfg: WearEnginePhonePeerConfig): void {
    this.peer = cfg;
    this.cachedAppParam = null;
  }

  private ensureInited(): void {
    if (!this.ctx || !this.authClient || !this.deviceClient || !this.p2pClient) {
      throw new Error('WearEngineService: call init(context) first');
    }
    if (!this.peer) {
      throw new Error('WearEngineService: call setPhonePeerConfig(...) first');
    }
  }

  async requestPermissions(perms: wearEngine.Permission[]): Promise<wearEngine.Permission[]> {
    this.ensureInited();
    const req: wearEngine.AuthorizationRequest = { permissions: perms };
    const res = await this.authClient!.requestAuthorization(req);
    return res.permissions;
  }

  private async pickPhoneDevice(): Promise<wearEngine.Device> {
    this.ensureInited();

    const devices = await this.deviceClient!.getConnectedDevices();
    if (!devices || devices.length === 0) {
      throw new Error('WearEngine: No connected device');
    }

    const phone = devices.find(d => d.category === wearEngine.DeviceCategory.WATCH) ?? devices[0];
    this.phoneDevice = phone;
    return phone;
  }

  private async ensureP2PSupported(): Promise<void> {
    this.ensureInited();
    if (!this.phoneDevice) {
      await this.pickPhoneDevice();
    }

    const ok = await this.phoneDevice!.isWearEngineCapabilitySupported(
      wearEngine.WearEngineCapability.P2P_COMMUNICATION
    );

    if (!ok) {
      throw new Error('Remote device does not support P2P communication');
    }
  }

  private buildAppParam(): wearEngine.P2pAppParam {
    if (this.cachedAppParam) {
      return this.cachedAppParam;
    }

    const appInfo: wearEngine.AppInfo = {
      bundleName: this.peer!.phoneBundleName,
      fingerprint: this.peer!.phoneFingerprint
    };

    const p: P2pAppParamCompat = { remoteApp: appInfo };
    p.transformLocalAppInfo = this.peer!.transformLocal ?? false;

    this.cachedAppParam = p as wearEngine.P2pAppParam;
    return this.cachedAppParam;
  }

  private decodeMessageToText(msg: wearEngine.P2pMessage): string | null {
    const m: P2pMessageCompat = msg as P2pMessageCompat;
    const v: Uint8Array | string | undefined = m.content ?? m.data ?? m.payload;

    if (typeof v === 'string') {
      return v;
    }
    if (v instanceof Uint8Array) {
      return this.decoder.decodeToString(v);
    }
    return null;
  }

  private toExerciseModel(dto: ExerciseDTO): ExerciseModel {
    const name = (typeof dto.name === 'string') ? dto.name : '';
    const duration = (typeof dto.duration === 'string') ? dto.duration : '';
    const src = (typeof dto.src === 'string') ? dto.src : '';

    return new ExerciseModel(IconConstants.YOGA_GIF, name, duration, src);
  }

  private toTrainingModel(dto: TrainingDTO): TrainingModel {
    const name = (typeof dto.name === 'string') ? dto.name : '';
    const duration = (typeof dto.duration === 'string') ? dto.duration : '';
    const difficulty = (typeof dto.difficulty === 'string') ? dto.difficulty : 'Medium';
    const calories = (typeof dto.calories === 'string') ? dto.calories : '~0';
    const src = (typeof dto.src === 'string') ? dto.src : '';

    const exModels: Array<ExerciseModel> = [];
    if (dto.exercises instanceof Array) {
      dto.exercises.forEach((e: ExerciseDTO) => exModels.push(this.toExerciseModel(e)));
    }

    return new TrainingModel(name, duration, difficulty, calories, src, exModels, IconConstants.BOLT);
  }

  private tryParseTrainings(text: string): Array<TrainingModel> | null {
    const trimmed = text.trim();
    if (!(trimmed.startsWith('{') || trimmed.startsWith('['))) {
      return null;
    }

    try {
      const parsed: Object = JSON.parse(trimmed) as Object;
      const asResp: TrainingResponseDTO = parsed as TrainingResponseDTO;

      const list1 = asResp.trainings;
      if (list1 instanceof Array) {
        return list1.map((t: TrainingDTO) => this.toTrainingModel(t));
      }

      const list2 = asResp.data;
      if (list2 instanceof Array) {
        return list2.map((t: TrainingDTO) => this.toTrainingModel(t));
      }

      const arr: Array<TrainingDTO> = parsed as Array<TrainingDTO>;
      if (arr instanceof Array) {
        return arr.map((t: TrainingDTO) => this.toTrainingModel(t));
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  async startListening(): Promise<void> {
    this.ensureInited();
    if (this.isListening) {
      return;
    }

    await this.ensureP2PSupported();

    if (!this.phoneDevice) {
      await this.pickPhoneDevice();
    }

    if (!this.receiverCb) {
      this.receiverCb = (p2pMessage: wearEngine.P2pMessage) => {
        const text = this.decodeMessageToText(p2pMessage);
        if (!text) {
          return;
        }

        this.onTextMessage?.(text);

        const trainings = this.tryParseTrainings(text);
        if (trainings && trainings.length > 0) {
          this.onTrainings?.(trainings);
        }
      };
    }

    await this.p2pClient!.registerMessageReceiver(
      this.phoneDevice!.randomId,
      this.buildAppParam(),
      this.receiverCb
    );

    this.isListening = true;
  }

  async stopListening(): Promise<void> {
    this.ensureInited();
    if (!this.phoneDevice || !this.receiverCb) {
      return;
    }
    if (!this.isListening) {
      return;
    }

    await this.p2pClient!.unregisterMessageReceiver(
      this.phoneDevice.randomId,
      this.buildAppParam(),
      this.receiverCb
    );

    this.isListening = false;
  }
}