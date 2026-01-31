import { TrackerDisplay } from '../../components/TrackerDisplay';
import { TrackerGoal } from '../../components/TrackerGoal';
import { TrackerHeader } from '../../components/TrackerHeader';
import { TrackerViewModel } from '../../viewmodel/TrackerViewModel';

@Component
export struct TrackerWeeklyView {
  @Consume('trackerViewModel') trackerViewModel: TrackerViewModel;
  title: string = 'Weekly';
  imagePath: Resource = $r('app.media.calender');
  color: Resource = $r('app.color.cerulean');
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
      .padding('48px')

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
        .backgroundColor($r('app.color.cod_gray'))
        .hitTestBehavior(HitTestMode.None)
    }
  }
}
