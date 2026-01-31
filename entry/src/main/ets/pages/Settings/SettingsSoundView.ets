import { AudioService } from '../../services/TrainingMusicService';

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
          .fontColor($r('app.color.international_orange'))
        Blank()
        Column() {
          Text('Volume')
            .fontColor($r('app.color.pure_white'))
            .fontSize($r('app.float.paragraph'))

          Blank()
          Row() {
            Slider({
              value: this.volume,
              min: 0,
              max: 100,
              style: SliderStyle.InSet
            })
              .selectedColor($r('app.color.international_orange'))
              .layoutWeight(1)
              .onChange(v => {
                this.volume = v;
                this.audioService.setVolume(v / 100);
              })

            Text(`${Math.round(this.volume)}%`)
              .fontSize($r('app.float.paragraph'))
              .fontColor($r('app.color.tundora'))
              .width('60px')
          }
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')

        Blank()

        Button({ type: ButtonType.Capsule }) {
          Image($r('app.media.chevron_left'))
            .fillColor($r('app.color.pure_white'))
            .width('30px')
            .aspectRatio(1)
        }
        .padding($r('app.float.pad_small'))
        .backgroundColor($r('app.color.cod_gray'))
        .onClick(() => this.settingsStack.pop())
      }
      .width('100%')
      .aspectRatio(1)
      .background($r('app.color.pure_black'))
      .padding('32px')
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true)
  }

}
