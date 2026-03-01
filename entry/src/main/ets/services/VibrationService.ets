// path: src/main/ets/service/VibrationService.ts
import vibrator from '@ohos.vibrator';
import { BusinessError } from '@ohos.base';

export class VibrationService {

  public static triggerVibration(duration: number = 500): void {
    try {
      vibrator.startVibration({
        type: 'time',
        duration: duration
      }, {
        id: 0,
        usage: 'alarm'
      }).then(() => {
        console.info('VibrationService: VibrationSuccess.');
      }).catch((error: BusinessError) => {
        if (error.code === 14600101) {
          console.warn('VibrationService: Error: EMULATOR?.');
        } else {
          console.error(`VibrationService Error Code: ${error.code}, Message: ${error.message}`);
        }
      });
    } catch (err) {
      console.error('VibrationService System Error:', JSON.stringify(err));
    }
  }
}