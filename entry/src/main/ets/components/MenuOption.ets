import { ColorConstants } from '../constants/ColorConstants';
import { IconConstants } from '../constants/IconConstants';
import { SizeConstants } from '../constants/SizeConstants';

@Component
export struct MenuOption {
  @Consume('menuSwiperIndex') menuSwiperIndex: number;

  icon: ResourceStr = '';
  label: string = '';
  targetIndex: number = 0;

  build() {
    Row({ space: SizeConstants.PAD_MINI }) {
      Image(this.icon)
        .width('32px')
        .aspectRatio(1)
        .fillColor(ColorConstants.PURE_WHITE)

      Text(this.label)
        .fontSize($r('app.float.subtitle'))
        .fontColor(ColorConstants.PURE_WHITE)

      Blank()

      Image(IconConstants.CHEVRON_DOWN)
        .width('32px')
        .aspectRatio(1)
        .fillColor(ColorConstants.PURE_WHITE)
    }
    .width('100%')
    .padding(SizeConstants.PAD_SMALL)
    .onClick(() => {
      this.getUIContext().animateTo({
        duration: 500,
        curve: Curve.EaseInOut
      }, () => {
        this.menuSwiperIndex = this.targetIndex;
      });
    })
  }
}
