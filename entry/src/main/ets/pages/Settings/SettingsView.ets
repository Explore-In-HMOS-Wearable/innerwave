import { SettingOption } from '../../model/SettingModel';
import { SettingsSoundView } from './SettingsSoundView';
import { ColorConstants } from '../../constants/ColorConstants';
import { IconConstants } from '../../constants/IconConstants';
import { SizeConstants } from '../../constants/SizeConstants';

@Component
export struct SettingsPage {
  @Provide('settingsStack') settingsStack: NavPathStack = new NavPathStack();

  private options: SettingOption[] = [
    { name: 'SoundSettings',
      label: 'Sound',
      icon: IconConstants.SPEAKER_WAVE_3
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
          .fontColor(ColorConstants.INTERNATIONAL_ORANGE)
        Blank()
        ForEach(this.options, (item: SettingOption) => {
          Row({ space: SizeConstants.PAD_MINI }) {
            Image(item.icon)
              .width('32px')
              .aspectRatio(1)
              .fillColor(ColorConstants.PURE_WHITE)

            Text(item.label)
              .fontSize($r('app.float.subtitle'))
              .fontColor(ColorConstants.PURE_WHITE)

            Blank()

            Image(IconConstants.CHEVRON_RIGHT)
              .width('16px')
              .aspectRatio(1)
              .fillColor(ColorConstants.PURE_WHITE)
          }
          .width('100%')
          .padding(SizeConstants.PAD_SMALL)
          .onClick(() => {
            this.settingsStack.pushPath({ name: item.name });
          });
        }, (item: SettingOption) => item.name)
        Blank()
      }

      .width('100%')
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .padding(SizeConstants.PAD_SCREEN)
    }
    .navDestination(this.pageMap)
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
