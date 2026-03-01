import { TrainingModel } from '../model/TrainingModel';
import { trainingStack } from '../navigation/TrainingNav';
import { ColorConstants } from '../constants/ColorConstants';
import { IconConstants } from '../constants/IconConstants';
import { SizeConstants } from '../constants/SizeConstants';

@Component
export struct TrainingActionButtons {
  @Prop item: TrainingModel;
  onBack: () => void = () => {};

  build() {
    Row({ space: SizeConstants.PAD_SMALL }) {
      Button({ type: ButtonType.Capsule }) {
        Image(IconConstants.CHEVRON_LEFT)
          .fillColor(ColorConstants.PURE_WHITE)
          .width('30px')
          .aspectRatio(1)
      }
      .padding(SizeConstants.PAD_MED)
      .backgroundColor(ColorConstants.COD_GRAY)
      .onClick(() => this.onBack())

      Button({ type: ButtonType.Capsule }) {
        Text('Start')
          .fontSize($r('app.float.content'))
          .fontWeight(FontWeight.Bold)
      }
      .backgroundColor(ColorConstants.CERULEAN)
      .padding(SizeConstants.PAD_BTN_PRIMARY)
      .onClick(() => {
        trainingStack.pushPath({ name: 'TrainingTimerPage', param: this.item });
      })
    }
    .width(130)
    .justifyContent(FlexAlign.Center)
  }
}