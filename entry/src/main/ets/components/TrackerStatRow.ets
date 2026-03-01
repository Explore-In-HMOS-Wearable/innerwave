import { TrackerStatCard } from './TrackerStatCard';
import { ColorConstants } from '../constants/ColorConstants';
import { IconConstants } from '../constants/IconConstants';

@Component
export struct TrackerStatRow {
  @Prop calories: string;
  @Prop distance: string;
  @Prop heartRate: string;

  build() {
    Row({ space: '24px' }) {
      TrackerStatCard({
        value: this.calories,
        unit: 'kcal',
        icon: IconConstants.FIRE,
        iconColor: ColorConstants.INTERNATIONAL_ORANGE
      })

      TrackerStatCard({
        value: this.distance,
        unit: 'km',
        icon: IconConstants.ROUTE_PLAN,
        iconColor: ColorConstants.CERULEAN
      })

      TrackerStatCard({
        value: this.heartRate,
        unit: 'bpm',
        icon: IconConstants.HEART_FILL,
        iconColor: ColorConstants.SCARLET
      })
    }
  }
}