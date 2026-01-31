import { TrackerDisplay } from '../../components/TrackerDisplay';
import { TrackerGoal } from '../../components/TrackerGoal';
import { TrackerHeader } from '../../components/TrackerHeader';
import { TrackerViewModel } from '../../viewmodel/TrackerViewModel';

@Component
export struct TrackerDailyView {
  @Consume('trackerViewModel') trackerViewModel: TrackerViewModel;
  title: string = 'Daily';
  imagePath: Resource = $r('app.media.calender');
  color: Resource = $r('app.color.chateau_green');
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
      .padding('48px')

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
        .backgroundColor($r('app.color.cod_gray'))
        .hitTestBehavior(HitTestMode.None)
    }
  }
}
