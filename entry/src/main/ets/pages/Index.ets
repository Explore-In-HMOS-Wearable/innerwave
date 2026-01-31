import { TrackerSwiperView } from '../pages/Tracker/TrackerSwiperView';
import { ArcDirection, ArcDotIndicator, ArcSwiper, ArcSwiperController, ArcSwiperAttribute } from '@kit.ArkUI';
import { TrainingView } from './Training/TrainingView';
import { TrackerViewModel } from '../viewmodel/TrackerViewModel';
import { ClockViewModel } from '../viewmodel/ClockViewModel';
import { MenuSwiper } from './Menu/MenuSwiper';

@Entry
@Component
struct Index {
  @Provide('swiperIndex') swiperIndex: number = 0;
  @Provide('trackerViewModel') trackerViewModel: TrackerViewModel = new TrackerViewModel();
  @Provide('clockViewModel') clockViewModel: ClockViewModel = new ClockViewModel();

  private wearableSwiperController: ArcSwiperController = new ArcSwiperController();
  private arcDotIndicator: ArcDotIndicator = new ArcDotIndicator();

  build() {
    Column() {
      ArcSwiper(this.wearableSwiperController) {
        MenuSwiper()
        TrackerSwiperView()
        TrainingView()
      }
      .width('100%')
      .aspectRatio(1)
      .index(this.swiperIndex)
      .onChange((index: number) => {
        this.swiperIndex = index;
      })
      .backgroundColor($r('app.color.pure_black'))
      .indicator(this.arcDotIndicator
        .arcDirection(ArcDirection.SIX_CLOCK_DIRECTION)
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
}
