import { ColorConstants } from '../constants/ColorConstants';
import { SizeConstants } from '../constants/SizeConstants';

@Component
export struct TrackerStatCard {
  @Prop value: string = '';
  @Prop unit: string = '';
  @Prop icon: Resource;
  @Prop iconColor: ResourceColor = '#FFFFFF';

  build() {
    Column() {
      Image(this.icon)
        .width('32px')
        .aspectRatio(1)
        .fillColor(this.iconColor)
        .objectFit(ImageFit.Contain)

      Blank()
        .height(SizeConstants.PAD_MINI)

      Text(this.value)
        .fontSize($r('app.float.subtitle'))
        .fontWeight(FontWeight.Bold)
        .fontColor(ColorConstants.PURE_WHITE)

      Text(this.unit)
        .fontSize($r('app.float.paragraph'))
        .fontColor(ColorConstants.TUNDORA)
    }
  }
}
