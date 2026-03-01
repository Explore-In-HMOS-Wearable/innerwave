import sensor from '@ohos.sensor';

export class HeartRateService {
  private static instance: HeartRateService;

  public static getInstance(): HeartRateService {
    if (!HeartRateService.instance) {
      HeartRateService.instance = new HeartRateService();
    }
    return HeartRateService.instance;
  }

  /**
   * Start sensor
   */
  public startMonitoring(onUpdate: (bpm: number) => void): void {
    try {

      sensor.on(sensor.SensorId.HEART_RATE, (data) => {
        if (data && data.heartRate) {
          onUpdate(Math.floor(data.heartRate));
        }
      }, { interval: 1000000000 });
      console.info('HeartRateService: Monitoring started');
    } catch (err) {
      console.error('HeartRateService Error:', JSON.stringify(err));
    }
  }

  /**
   * Stop sensor
   */
  public stopMonitoring(): void {
    try {
      sensor.off(sensor.SensorId.HEART_RATE);
      console.info('HeartRateService: Monitoring stopped');
    } catch (err) {
      console.error('HeartRateService Stop Error:', JSON.stringify(err));
    }
  }
}