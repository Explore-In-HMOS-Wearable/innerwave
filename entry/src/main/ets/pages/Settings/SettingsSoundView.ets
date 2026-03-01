import { AudioService } from '../../services/TrainingMusicService';
import { ColorConstants } from '../../constants/ColorConstants';
import { IconConstants } from '../../constants/IconConstants';
import { SizeConstants } from '../../constants/SizeConstants';

@Component
export struct SettingsSoundView {
  private audioService = AudioService.getInstance();
  @Consume('settingsStack') settingsStack: NavPathStack;
  @State volume: number = AudioService.getInstance().getCurrentVolume() * 100;

  build() {
    NavDestination() {
      Column() {
        Text('Settings')
          .fontSize($r('app.float.content'))
          .fontColor(ColorConstants.INTERNATIONAL_ORANGE)
        Blank()
        Column() {
          Text('Volume')
            .fontColor(ColorConstants.PURE_WHITE)
            .fontSize($r('app.float.paragraph'))

          Blank()
          Row() {
            Slider({
              value: this.volume,
              min: 0,
              max: 100,
              style: SliderStyle.InSet
            })
              .selectedColor(ColorConstants.INTERNATIONAL_ORANGE)
              .layoutWeight(1)
              .onChange(v => {
                this.volume = v;
                this.audioService.setVolume(v / 100);
              })

            Text(`${Math.round(this.volume)}%`)
              .fontSize($r('app.float.paragraph'))
              .fontColor(ColorConstants.TUNDORA)
              .width('60px')
          }
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')

        Blank()

        Button({ type: ButtonType.Capsule }) {
          Image(IconConstants.CHEVRON_LEFT)
            .fillColor(ColorConstants.PURE_WHITE)
            .width('30px')
            .aspectRatio(1)
        }
        .padding(SizeConstants.PAD_SMALL)
        .backgroundColor(ColorConstants.COD_GRAY)
        .onClick(() => this.settingsStack.pop())
      }
      .width('100%')
      .aspectRatio(1)
      .background(ColorConstants.PURE_BLACK)
      .padding(SizeConstants.PAD_LARGE)
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true)
  }

}
