import { ArcDirection, ArcDotIndicator, ArcSwiper, ArcSwiperAttribute } from '@kit.ArkUI';
import { TrackerDailyView } from './TrackerDailyView';
import { TrackerGoalView } from './TrackerGoalView';
import { TrackerHubView } from './TrackerHubView';
import { TrackerWeeklyView } from './TrackerWeeklyView';

@Component
export struct TrackerSwiperView {
  @State swiperIndex: number = 0;
  private swiperController: SwiperController = new SwiperController();
  private arcDotIndicator: ArcDotIndicator = new ArcDotIndicator();

  build() {
    ArcSwiper(this.swiperController) {
      TrackerHubView()
      TrackerDailyView()
      TrackerWeeklyView()
      TrackerGoalView()
    }
    .vertical(true)
    .index(this.swiperIndex)
    .onChange((index: number) => {
      this.swiperIndex = index;
    })
    .indicator(this.arcDotIndicator
      .arcDirection(ArcDirection.THREE_CLOCK_DIRECTION)
      .itemColor($r('app.color.tundora'))
      .selectedItemColor($r('app.color.pure_white'))
      .maskColor(new LinearGradient([
        {
          color: Color.Transparent,
          offset: 0
        },
        {
          color: Color.Transparent,
          offset: 1
        }
      ]))
    )
  }
}