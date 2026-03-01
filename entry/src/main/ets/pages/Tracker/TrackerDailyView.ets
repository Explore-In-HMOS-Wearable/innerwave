import { TrackerDisplay } from '../../components/TrackerDisplay';
import { TrackerGoal } from '../../components/TrackerGoal';
import { TrackerHeader } from '../../components/TrackerHeader';
import { TrackerViewModel } from '../../viewmodel/TrackerViewModel';
import { ColorConstants } from '../../constants/ColorConstants';
import { IconConstants } from '../../constants/IconConstants';
import { SizeConstants } from '../../constants/SizeConstants';

@Component
export struct TrackerDailyView {
  @Consume('trackerViewModel') trackerViewModel: TrackerViewModel;
  title: string = 'Daily';
  imagePath: Resource = IconConstants.CALENDER;
  color: Resource = ColorConstants.CHATEAU_GREEN;
  subtitle: string = 'STEPS';

  build() {
    Stack() {
      Column() {
        TrackerHeader({
          imagePath: this.imagePath,
          title: this.title,
          iconColor: this.color
        })

        Blank()

        TrackerDisplay({
          title: this.trackerViewModel.data.dailySteps.toString(),
          subtitle: this.subtitle
        })

        Blank()

        TrackerGoal({
          goal: this.trackerViewModel.data.dailyStepGoal,
          progress: this.trackerViewModel.getDailyProgress(),
          color: this.color
        })
      }
      .width('100%')
      .aspectRatio(1)
      .padding(SizeConstants.PAD_XL)

      Progress({
        value: this.trackerViewModel.data.dailySteps,
        total: this.trackerViewModel.data.dailyStepGoal,
        type: ProgressType.Ring
      })
        .width('100%')
        .aspectRatio(1)
        .style({
          strokeWidth: '16px',
          enableSmoothEffect: true
        })
        .color(this.color)
        .backgroundColor(ColorConstants.COD_GRAY)
        .hitTestBehavior(HitTestMode.None)
    }
  }
}