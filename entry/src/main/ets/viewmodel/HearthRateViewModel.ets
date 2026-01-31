import { sensor } from '@kit.SensorServiceKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { abilityAccessCtrl, bundleManager, common } from '@kit.AbilityKit';

@Observed
export class HeartRateViewModel {
  public heartRate: number = 0;
  private readonly INTERVAL: number = 200000000;
  private status: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;

  public async start(context: common.Context) {
    const atManager = abilityAccessCtrl.createAtManager();
    try {
      const bundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.
      BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      const tokenId = bundleInfo.appInfo.accessTokenId;

      this.status = await atManager.checkAccessToken(tokenId, 'ohos.permission.READ_HEALTH_DATA');
    } catch (error) {
      console.error(`Permission control unsuccessful: ${JSON.stringify(error)}`);
      return;
    }

    if (this.status !== abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      console.error('Health data access permission has not been granted.' +
        'Please enable it in the settings.\n');
      return;
    }

    try {
      sensor.on(sensor.SensorId.HEART_RATE, (data: sensor.HeartRateResponse) => {
        this.heartRate = data.heartRate;
      }, { interval: this.INTERVAL });
    } catch (error) {
      const e: BusinessError = error as BusinessError;
      console.error(`Sensor hatası: ${e.code} - ${e.message}`);
    }
  }

  public stop() {
    try {
      sensor.off(sensor.SensorId.HEART_RATE);
    } catch (error) {
      console.error('Sensors could not stop');
    }
  }
}
