import { SettingOption } from '../../model/SettingModel';
import { SettingsSoundView } from './SettingsSoundView';

@Component
export struct SettingsPage {
  @Provide('settingsStack') settingsStack: NavPathStack = new NavPathStack();

  private options: SettingOption[] = [
    { name: 'SoundSettings',
      label: 'Sound',
      icon: $r('app.media.speaker_wave_3')
    }
  ];

  @Builder
  pageMap(name: string) {
    if (name === 'SoundSettings') {
      SettingsSoundView()
    }
  }

  build() {
    Navigation(this.settingsStack) {
      Column() {
        Text('Settings')
          .fontSize($r('app.float.title'))
          .fontColor($r('app.color.international_orange'))
        Blank()
        ForEach(this.options, (item: SettingOption) => {
          Row({ space: 8 }) {
            Image(item.icon)
              .width('32px')
              .aspectRatio(1)
              .fillColor($r('app.color.pure_white'))

            Text(item.label)
              .fontSize($r('app.float.subtitle'))
              .fontColor($r('app.color.pure_white'))

            Blank()

            Image($r('app.media.chevron_right'))
              .width('16px')
              .aspectRatio(1)
              .fillColor($r('app.color.pure_white'))
          }
          .width('100%')
          .padding($r('app.float.pad_small'))
          .onClick(() => {
            this.settingsStack.pushPath({ name: item.name });
          });
        }, (item: SettingOption) => item.name)
        Blank()
      }

      .width('100%')
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .padding({
        top: '32px',
        bottom: '32px',
        left: '64px',
        right: '64px'
      })
    }
    .navDestination(this.pageMap)
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
