import { TrainingItem } from '../model/TrainingItem';
import { trainingStack } from '../navigation/TrainingNav';

@Component
export struct TrainingActionButtons {
  @Prop item: TrainingItem;
  onBack: () => void = () => {};

  build() {
    Row({ space: $r('app.float.pad_small') }) {
      Button({ type: ButtonType.Capsule }) {
        Image($r('app.media.chevron_left'))
          .fillColor($r('app.color.pure_white'))
          .width('30px')
          .aspectRatio(1)
      }
      .padding($r('app.float.pad_med'))
      .backgroundColor($r('app.color.cod_gray'))
      .onClick(() => this.onBack())

      Button({ type: ButtonType.Capsule }) {
        Text('Start')
          .fontSize($r('app.float.content'))
          .fontWeight(FontWeight.Bold)
      }
      .backgroundColor($r('app.color.cerulean'))
      .padding({
        top: $r('app.float.pad_med'),
        bottom: $r('app.float.pad_med'),
        left: $r('app.float.pad_large'),
        right: $r('app.float.pad_large')
      })
      .onClick(() => {
        trainingStack.pushPath({ name: 'TrainingTimerPage', param: this.item });
      })

    }
    .width(130)
    .justifyContent(FlexAlign.Center)
  }
}
