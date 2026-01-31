import { TrackerViewModel } from '../../viewmodel/TrackerViewModel';
import { TrackerStatRow } from '../../components/TrackerStatRow';
import { PermissionUtil } from '../../utils/PermissionUtil';
import { HeartRateViewModel } from '../../viewmodel/HearthRateViewModel';
import { TrackerHeader } from '../../components/TrackerHeader';
import { TrackerDisplay } from '../../components/TrackerDisplay';
import { ClockViewModel } from '../../viewmodel/ClockViewModel';
import { common } from '@kit.AbilityKit';

@Component
export struct TrackerHubView {
  @Consume('trackerViewModel') trackerViewModel: TrackerViewModel;
  @Consume('clockViewModel') clockViewModel: ClockViewModel;

  title: string = 'Innerwave';
  imagePath: Resource = $r('app.media.bolt');
  iconColor: Resource = $r('app.color.international_orange');

  @State private hrViewModel: HeartRateViewModel = new HeartRateViewModel();

  aboutToAppear() {
    try {
      const context = this.getUIContext().getHostContext() as common.UIAbilityContext;
      PermissionUtil.requestPermissions(['ohos.permission.READ_HEALTH_DATA'], context);
      this.hrViewModel.start(context);
    } catch (error) {
      console.error(`Error occured while starting: ${JSON.stringify(error)}`);
    }
  }

  aboutToDisappear() {
    this.hrViewModel.stop();
  }

  build() {
    Stack() {
      Column() {
        TrackerHeader({
          title: this.title,
          imagePath: this.imagePath,
          iconColor: this.iconColor
        })

        Blank()

        TrackerDisplay({
          title: this.clockViewModel.currentTime,
          subtitle: this.clockViewModel.amPm
        })

        Blank()

        TrackerStatRow({
          calories: this.trackerViewModel.data.calories.toString(),
          distance: this.trackerViewModel.data.distance.toString(),
          heartRate: this.hrViewModel.heartRate.toString()
        })
      }
      .width('100%')
      .aspectRatio(1)
      .padding('64px')

      Stack() {
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
          .color($r('app.color.cerulean'))
          .backgroundColor($r('app.color.cod_gray'))
          .hitTestBehavior(HitTestMode.None)

        Progress({
          value: this.trackerViewModel.data.dailySteps,
          total: this.trackerViewModel.data.dailyStepGoal,
          type: ProgressType.Ring
        })
          .width('92%')
          .aspectRatio(1)
          .style({
            strokeWidth: '16px',
            enableSmoothEffect: true
          })
          .color($r('app.color.chateau_green'))
          .backgroundColor($r('app.color.cod_gray'))
          .hitTestBehavior(HitTestMode.None)
      }
    }
  }
}