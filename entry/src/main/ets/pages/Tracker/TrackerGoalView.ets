import { TrackerDisplay } from '../../components/TrackerDisplay';
import { TrackerViewModel } from '../../viewmodel/TrackerViewModel';

@Component
export struct TrackerGoalView {
  @Consume('trackerViewModel') trackerViewModel: TrackerViewModel;

  aboutToAppear() {
    this.trackerViewModel.initTempGoal();
  }

  build() {
    Column() {
      Row({ space: $r('app.float.pad_mini') }) {
        Image($r('app.media.repeat'))
          .width('32px')
          .aspectRatio(1)
          .fillColor($r('app.color.pure_white'))

        Text(this.trackerViewModel.selectedIndex === 0 ? 'Daily Goal' : 'Weekly Goal')
          .fontSize($r('app.float.paragraph'))
          .fontColor($r('app.color.pure_white'))
      }
      .borderRadius(999)
      .padding($r('app.float.pad_small'))
      .backgroundColor($r('app.color.mine_shaft'))
      .onClick(() => {
        this.trackerViewModel.selectedIndex = this.trackerViewModel.selectedIndex === 0 ? 1 : 0;
        this.trackerViewModel.initTempGoal();
      })

      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle().width('64px')
            .height('64px')
            .fill($r('app.color.cod_gray'))

          Image($r('app.media.minus'))
            .width('32px')
            .height('32px')
            .fillColor(Color.White)
        }
        .onClick(() => this.trackerViewModel.updateTempGoal(false))

        TrackerDisplay({
          title: this.trackerViewModel.tempGoal.toString(),
          subtitle: 'Steps'
        })

        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width('64px')
            .height('64px')
            .fill($r('app.color.cod_gray'))

          Image($r('app.media.plus'))
            .width('32px')
            .height('32px')
            .fillColor(Color.White)
        }
        .onClick(() => this.trackerViewModel.updateTempGoal(true))
      }
      .justifyContent(FlexAlign.SpaceBetween).width('100%')

      Row({ space: $r('app.float.pad_mini') }) {
        Text('Cancel')
          .fontColor($r('app.color.scarlet'))
          .fontSize($r('app.float.paragraph'))
          .padding($r('app.float.pad_small'))
          .visibility(this.trackerViewModel.isModified ? Visibility.Visible : Visibility.Hidden)
          .onClick(() => {
            this.trackerViewModel.cancelGoal();
          })

        Text('Confirm')
          .borderRadius(999)
          .backgroundColor(this.trackerViewModel.isModified ? $r('app.color.mine_shaft') : $r('app.color.cod_gray'))
          .fontColor(this.trackerViewModel.isModified ? $r('app.color.pure_white') : $r('app.color.tundora'))
          .fontSize($r('app.float.paragraph'))
          .fontWeight(FontWeight.Medium)
          .padding($r('app.float.pad_small'))
          .enabled(this.trackerViewModel.isModified)
          .onClick(() => {
            this.trackerViewModel.confirmGoal();
          })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      top: '48px',
      bottom: '48px',
      left: '32px',
      right: '32px'
    })
  }
}