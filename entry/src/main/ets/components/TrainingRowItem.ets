import { trainingStack } from '../navigation/TrainingNav';
import { TrainingItem } from '../model/TrainingItem';

@Component
export struct TrainingRowItem {
  @Prop item: TrainingItem;

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width('64px')
          .height('64px')
          .fill($r('app.color.mine_shaft'))

        Image($r('app.media.bolt'))
          .width('32px')
          .height('32px')
          .fillColor($r('app.color.pure_white'))
          .objectFit(ImageFit.Contain)
      }

      Blank().width('8px')

      Text(this.item.title)
        .fontSize($r('app.float.content'))
        .fontColor($r('app.color.pure_white'))
        .fontWeight(FontWeight.Medium)

      Blank().layoutWeight(1)

      Text(this.item.duration)
        .fontSize($r('app.float.paragraph'))
        .fontColor($r('app.color.pure_white'))
    }
    .layoutWeight(1)
    .padding($r('app.float.pad_med'))
    .margin({
      top: $r('app.float.pad_mini'),
      bottom: $r('app.float.pad_mini'),
      right: $r('app.float.pad_large'),
      left: $r('app.float.pad_large')
    })
    .borderRadius(999)
    .backgroundColor($r('app.color.cod_gray'))
    .onClick(() => {
      trainingStack.pushPathByName('TrainingDetailPage', this.item);
    })
  }
}
