import { ColorConstants } from '../constants/ColorConstants';
import { IconConstants } from '../constants/IconConstants';
import { SizeConstants } from '../constants/SizeConstants';

@Component
export struct TrainingStatsItem {
  icon: Resource = IconConstants.BOLT;
  label: string = '';
  value: string = '';

  build() {
    Row({ space: SizeConstants.PAD_MINI }) {
      Image(this.icon)
        .width('48px')
        .aspectRatio(1)
        .fillColor(ColorConstants.PURE_WHITE)
        .objectFit(ImageFit.Contain)

      Column() {
        Text(this.label)
          .fontSize($r('app.float.paragraph'))
          .fontColor(ColorConstants.TUNDORA)

        Text(this.value)
          .fontSize($r('app.float.content'))
          .fontColor(ColorConstants.PURE_WHITE)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}