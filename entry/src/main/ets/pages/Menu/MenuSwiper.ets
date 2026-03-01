import { ArcDirection, ArcDotIndicator, ArcSwiper, ArcSwiperAttribute } from '@kit.ArkUI';
import { ColorConstants } from '../../constants/ColorConstants';
import { SettingsPage } from '../Settings/SettingsView';
import { MenuAboutView } from './MenuAboutView';
import { MenuView } from './MenuView';

@Component
export struct MenuSwiper {
  @Provide('menuSwiperIndex') menuSwiperIndex: number = 0;
  private swiperController: SwiperController = new SwiperController();
  private arcDotIndicator: ArcDotIndicator = new ArcDotIndicator();

  build() {
    ArcSwiper(this.swiperController) {
      MenuView()
      SettingsPage()
      MenuAboutView()
    }
    .vertical(true)
    .index(this.menuSwiperIndex)
    .onChange((index: number) => {
      this.menuSwiperIndex = index;
    })
    .indicator(this.arcDotIndicator
      .arcDirection(ArcDirection.NINE_CLOCK_DIRECTION)
      .itemColor(ColorConstants.TUNDORA)
      .selectedItemColor(ColorConstants.PURE_WHITE)
      .maskColor(new LinearGradient([
        {
          color: Color.Transparent,
          offset: 0
        },
        {
          color: Color.Transparent,
          offset: 1
        }
      ]))
    )
  }
}