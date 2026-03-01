import { trainingStack } from '../navigation/TrainingNav';
import { TrainingModel } from '../model/TrainingModel';
import { ColorConstants } from '../constants/ColorConstants';
import { SizeConstants } from '../constants/SizeConstants';

@Component
export struct TrainingRowItem {
  @Prop item: TrainingModel;

  build() {
    Row() {
      Image(this.item.thumbnail)
        .width('64px')
        .height('64px')
        .objectFit(ImageFit.Cover)
        .borderRadius(9999)
        .clip(true)

      Blank().width(SizeConstants.PAD_MINI)

      Text(this.item.name)
        .fontSize($r('app.float.content'))
        .fontColor(ColorConstants.PURE_WHITE)
        .fontWeight(FontWeight.Medium)

      Blank().layoutWeight(1)

      Text(this.item.duration)
        .fontSize($r('app.float.paragraph'))
        .fontColor(ColorConstants.PURE_WHITE)
    }
    .layoutWeight(1)
    .padding(SizeConstants.PAD_MED)
    .margin({
      top: SizeConstants.PAD_MINI,
      bottom: SizeConstants.PAD_MINI,
      right: SizeConstants.PAD_MED,
      left: SizeConstants.PAD_MED
    })
    .borderRadius(999)
    .backgroundColor(ColorConstants.COD_GRAY)
    .onClick(() => {
      trainingStack.pushPathByName('TrainingDetailPage', this.item);
    })
  }
}