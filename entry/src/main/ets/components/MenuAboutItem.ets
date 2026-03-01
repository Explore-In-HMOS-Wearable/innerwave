import { ColorConstants } from '../constants/ColorConstants';
import { SizeConstants } from '../constants/SizeConstants';

@Component
export struct MenuAboutItem {
  title: string = '';
  value: string = '';

  build() {
    Row() {
      Text(this.title)
        .fontSize($r('app.float.content'))
        .fontWeight(FontWeight.Medium)
        .layoutWeight(1)

      Text(this.value)
        .fontSize($r('app.float.paragraph'))
        .fontColor(ColorConstants.TUNDORA)
        .textAlign(TextAlign.End)
        .layoutWeight(2)
        .maxLines(2)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .padding(SizeConstants.PAD_SMALL)

  }
}
