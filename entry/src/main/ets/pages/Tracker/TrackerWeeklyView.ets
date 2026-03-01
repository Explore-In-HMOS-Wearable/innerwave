import { TrackerDisplay } from '../../components/TrackerDisplay';
import { TrackerGoal } from '../../components/TrackerGoal';
import { TrackerHeader } from '../../components/TrackerHeader';
import { TrackerViewModel } from '../../viewmodel/TrackerViewModel';
import { ColorConstants } from '../../constants/ColorConstants';
import { IconConstants } from '../../constants/IconConstants';
import { SizeConstants } from '../../constants/SizeConstants';

@Component
export struct TrackerWeeklyView {
  @Consume('trackerViewModel') trackerViewModel: TrackerViewModel;
  title: string = 'Weekly';
  imagePath: Resource = IconConstants.CALENDER;
  color: Resource = ColorConstants.CERULEAN;
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
          title: this.trackerViewModel.data.weeklySteps.toString(),
          subtitle: this.subtitle
        })

        Blank()

        TrackerGoal({
          goal: this.trackerViewModel.data.weeklyStepGoal,
          progress: this.trackerViewModel.getWeeklyProgress(),
          color: this.color
        })
      }
      .width('100%')
      .aspectRatio(1)
      .padding(SizeConstants.PAD_XL)

      Progress({
        value: this.trackerViewModel.data.weeklySteps,
        total: this.trackerViewModel.data.weeklyStepGoal,
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
