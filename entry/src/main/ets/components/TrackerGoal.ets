import { ColorConstants } from '../constants/ColorConstants';
import { SizeConstants } from '../constants/SizeConstants';

@Component
export struct TrackerGoal {
  @Prop goal: number = 0;
  @Prop progress: number = 0;
  @Prop color: Resource;

  build() {
    Column({ space: SizeConstants.PAD_MINI }) {
      Text(`Goal: ${this.goal}`)
        .fontSize($r('app.float.paragraph'))
        .fontColor(ColorConstants.PURE_WHITE)

      Text(`${this.progress}% Completed`)
        .fontSize($r('app.float.content'))
        .fontColor(this.color)
    }
  }
}