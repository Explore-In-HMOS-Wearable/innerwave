import { TrackerStatCard } from './TrackerStatCard';

@Component
export struct TrackerStatRow {
  @Prop calories: string;
  @Prop distance: string;
  @Prop heartRate: string;

  build() {
    Row({ space: '48px' }) {
      TrackerStatCard({
        value: this.calories,
        unit: 'kcal',
        icon: $r('app.media.sun_max'),
        iconColor: $r('app.color.international_orange')
      })

      TrackerStatCard({
        value: this.distance,
        unit: 'km',
        icon: $r('app.media.route_plan'),
        iconColor: $r('app.color.cerulean')
      })

      TrackerStatCard({
        value: this.heartRate,
        unit: 'bpm',
        icon: $r('app.media.heart'),
        iconColor: $r('app.color.scarlet')
      })
    }
  }
}