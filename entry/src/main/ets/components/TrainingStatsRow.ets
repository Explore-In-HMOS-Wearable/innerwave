import { TrainingModel } from '../model/TrainingModel';
import { TrainingStatsItem } from './TrainingStatsItem';
import { IconConstants } from '../constants/IconConstants';

@Component
export struct TrainingStatsRow {
  @Prop item: TrainingModel;

  build() {
    Row() {
      TrainingStatsItem({
        icon: IconConstants.BOLT,
        label: 'Difficulty',
        value: this.item.difficulty
      })

      TrainingStatsItem({
        icon: IconConstants.SUN_MAX,
        label: 'Calories',
        value: this.item.calories
      })

      TrainingStatsItem({
        icon: IconConstants.CLOCK,
        label: 'Time',
        value: this.item.duration
      })
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .width('100%')
  }
}