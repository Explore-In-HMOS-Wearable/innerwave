import { ColorConstants } from '../constants/ColorConstants';

@Component
export struct TrackerDisplay {
  @Prop title: string = '';
  @Prop subtitle: string = '';

  build() {
    Column() {
      Text(this.title)
        .fontSize($r('app.float.hero'))
        .fontColor(ColorConstants.PURE_WHITE)
        .fontWeight(FontWeight.Bolder)

      Text(this.subtitle)
        .fontSize($r('app.float.content'))
        .fontColor(ColorConstants.TUNDORA)
        .fontWeight(FontWeight.Bold)
    }
  }
}