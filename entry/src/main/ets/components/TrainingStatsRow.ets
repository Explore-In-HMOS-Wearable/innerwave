import { TrainingItem } from '../model/TrainingItem';
import { TrainingStatsItem } from './TrainingStatsItem';

@Component
export struct TrainingStatsRow {
  @Prop item: TrainingItem;

  build() {
    Row() {
      TrainingStatsItem({
        icon: $r('app.media.bolt'),
        label: 'Difficulty',
        value: this.item.difficulty
      })

      TrainingStatsItem({
        icon: $r('app.media.sun_max'),
        label: 'Calories',
        value: this.item.calories
      })

      TrainingStatsItem({
        icon: $r('app.media.clock'),
        label: 'Time',
        value: this.item.duration
      })
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .width('100%')
  }
}