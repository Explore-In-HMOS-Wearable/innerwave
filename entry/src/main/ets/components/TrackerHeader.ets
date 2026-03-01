import { ColorConstants } from '../constants/ColorConstants';
import { SizeConstants } from '../constants/SizeConstants';

@Component
export struct TrackerHeader {
  @Prop title: string;
  @Prop imagePath: Resource;
  @Prop iconColor: Resource;

  build() {
    Column({ space: SizeConstants.PAD_MINI }) {
      Image(this.imagePath)
        .width('36px')
        .aspectRatio(1)
        .fillColor(this.iconColor)

      Text(this.title)
        .fontSize($r('app.float.paragraph'))
        .fontColor(ColorConstants.PURE_WHITE)
    }
  }
}
