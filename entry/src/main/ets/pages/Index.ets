import { TrackerSwiperView } from '../pages/Tracker/TrackerSwiperView';
import { ArcDirection, ArcDotIndicator, ArcSwiper, ArcSwiperController, ArcSwiperAttribute } from '@kit.ArkUI';
import { TrainingView } from './Training/TrainingView';
import { TrackerViewModel } from '../viewmodel/TrackerViewModel';
import { ClockViewModel } from '../viewmodel/ClockViewModel';
import { MenuSwiper } from './Menu/MenuSwiper';
import { ColorConstants } from '../constants/ColorConstants';

@Entry
@Component
struct Index {
  @Provide('swiperIndex') swiperIndex: number = 1;
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
      .backgroundColor(ColorConstants.PURE_BLACK)
      .indicator(this.arcDotIndicator
        .arcDirection(ArcDirection.SIX_CLOCK_DIRECTION)
        .itemColor(ColorConstants.TUNDORA)
        .selectedItemColor(ColorConstants.PURE_WHITE)
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