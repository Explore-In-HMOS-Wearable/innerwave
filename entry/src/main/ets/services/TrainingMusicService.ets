import media from '@ohos.multimedia.media';
import { common } from '@kit.AbilityKit';
import { audio } from '@kit.AudioKit';

export enum AudioStatus {
  undefined = 0,
  playing,
  paused,
  released
}

@ObservedV2
export class AudioService {

  static _instance: AudioService;
  private currentVolume: number = 0.5;
  static getInstance() {
    if (!AudioService._instance) {
      AudioService._instance = new AudioService(AudioStatus.undefined);
    }
    return AudioService._instance;
  }

  constructor(audioStatus: AudioStatus) {
    this.audioStatus = audioStatus;
  }

  private player: media.AVPlayer | undefined;
  @Trace audioStatus: AudioStatus;

  setCallBacks(avPlayer: media.AVPlayer) {
    avPlayer.on('stateChange', async (state: string) => {
      console.info('AVPlayer State: ', state);

      switch (state) {
        case 'initialized':
          avPlayer.audioRendererInfo = {
            usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
            rendererFlags: 0
          };
          avPlayer.prepare().catch(() => {
            // TODO: Implement error handling.
          });
          break;

        case 'prepared':
          avPlayer.setVolume(this.currentVolume);
          this.audioStatus = AudioStatus.playing;
          avPlayer.play().catch(() => {
            // TODO: Implement error handling.
          });
          break;

        case 'completed':
          this.audioStatus = AudioStatus.released;
          avPlayer.stop().catch(() => {
            // TODO: Implement error handling.
          });
          break;

        case 'stopped':
          avPlayer.reset().catch(() => {
            // TODO: Implement error handling.
          });
          break;

        case 'pause':
          avPlayer.pause().catch(() => {
            // TODO: Implement error handling.
          });
          break;

        default:
          break;
      }

    });

    avPlayer.on('error', (err) => {
      console.error('AVPlayer Error', err.message);
      avPlayer.reset().catch(() => {
        // TODO: Implement error handling.
      });
    });
  }

  public async playEmbeddedMp3(ctx: common.UIAbilityContext, fileName: string) {
    this.release();
    const resourceFd = await ctx.resourceManager.getRawFd(fileName);
    const avFileDescriptor: media.AVFileDescriptor = {
      fd: resourceFd.fd,
      offset: resourceFd.offset,
      length: resourceFd.length
    };
    this.player = await media.createAVPlayer();
    this.setCallBacks(this.player);
    this.player.fdSrc = avFileDescriptor;
  }

  public pause() {
    this.audioStatus = AudioStatus.paused;
    this.player?.pause().catch(() => {
      // TODO: Implement error handling.
    });
  }

  public resume() {
    this.audioStatus = AudioStatus.playing;
    this.player?.play().catch(() => {
      // TODO: Implement error handling.
    });
  }

  public stop() {
    this.audioStatus = AudioStatus.released;
    this.player?.stop().catch(() => {
      // TODO: Implement error handling.
    });
  }

  public release() {
    this.audioStatus = AudioStatus.released;
    this.player?.reset().catch(() => {
      // TODO: Implement error handling.
    });
  }

  public setVolume(level: number) {
    this.currentVolume = Math.max(0, Math.min(1, level));
    console.info(`Volume memory updated to: ${this.currentVolume}`);

    if (this.player && this.player.state !== 'idle' && this.player.state !== 'released') {
      try {
        this.player.setVolume(this.currentVolume);
      } catch (e) {
      }
    }
  }

  public getCurrentVolume(): number {
    return this.currentVolume;
  }
}
