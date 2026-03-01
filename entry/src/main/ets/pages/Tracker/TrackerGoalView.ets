import { TrackerDisplay } from '../../components/TrackerDisplay';
import { TrackerViewModel } from '../../viewmodel/TrackerViewModel';
import { ColorConstants } from '../../constants/ColorConstants';
import { IconConstants } from '../../constants/IconConstants';
import { SizeConstants } from '../../constants/SizeConstants';

@Component
export struct TrackerGoalView {
  @Consume('trackerViewModel') trackerViewModel: TrackerViewModel;

  aboutToAppear() {
    this.trackerViewModel.initTempGoal();
  }

  build() {
    Column() {
      Row({ space: SizeConstants.PAD_MINI }) {
        Image(IconConstants.REPEAT)
          .width('32px')
          .aspectRatio(1)
          .fillColor(ColorConstants.PURE_WHITE)

        Text(this.trackerViewModel.selectedIndex === 0 ? 'Daily Goal' : 'Weekly Goal')
          .fontSize($r('app.float.paragraph'))
          .fontColor(ColorConstants.PURE_WHITE)
      }
      .borderRadius(999)
      .padding(SizeConstants.PAD_SMALL)
      .backgroundColor(ColorConstants.MINE_SHAFT)
      .onClick(() => {
        this.trackerViewModel.selectedIndex = this.trackerViewModel.selectedIndex === 0 ? 1 : 0;
        this.trackerViewModel.initTempGoal();
      })

      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle().width('64px')
            .height('64px')
            .fill(ColorConstants.COD_GRAY)

          Image(IconConstants.MINUS)
            .width('32px')
            .height('32px')
            .fillColor(ColorConstants.PURE_WHITE)
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
            .fill(ColorConstants.COD_GRAY)

          Image(IconConstants.PLUS)
            .width('32px')
            .height('32px')
            .fillColor(ColorConstants.PURE_WHITE)
        }
        .onClick(() => this.trackerViewModel.updateTempGoal(true))
      }
      .justifyContent(FlexAlign.SpaceBetween).width('100%')

      Row({ space: SizeConstants.PAD_MINI }) {
        Text('Cancel')
          .fontColor(ColorConstants.SCARLET)
          .fontSize($r('app.float.paragraph'))
          .padding(SizeConstants.PAD_SMALL)
          .visibility(this.trackerViewModel.isModified ? Visibility.Visible : Visibility.Hidden)
          .onClick(() => {
            this.trackerViewModel.cancelGoal();
          })

        Text('Confirm')
          .borderRadius(999)
          .backgroundColor(this.trackerViewModel.isModified ? ColorConstants.MINE_SHAFT : ColorConstants.COD_GRAY)
          .fontColor(this.trackerViewModel.isModified ? ColorConstants.PURE_WHITE : ColorConstants.TUNDORA)
          .fontSize($r('app.float.paragraph'))
          .fontWeight(FontWeight.Medium)
          .padding(SizeConstants.PAD_SMALL)
          .enabled(this.trackerViewModel.isModified)
          .onClick(() => {
            this.trackerViewModel.confirmGoal();
          })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(SizeConstants.PAD_INNER)
  }
}