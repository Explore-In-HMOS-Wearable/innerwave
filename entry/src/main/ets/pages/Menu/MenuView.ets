import { MenuNavigation } from '../../components/MenuNavigation';
import { MenuOption } from '../../components/MenuOption';
import { ColorConstants } from '../../constants/ColorConstants';
import { IconConstants } from '../../constants/IconConstants';
import { SizeConstants } from '../../constants/SizeConstants';

@Component
export struct MenuView {
  @Consume('swiperIndex') swiperIndex: number;
  @Consume('menuSwiperIndex') menuSwiperIndex: number;

  build() {
    Column() {
      Text('Menu')
        .fontSize($r('app.float.title'))
        .fontColor(ColorConstants.INTERNATIONAL_ORANGE)
      Blank()
      MenuNavigation({
        icon: IconConstants.TRACKING,
        label: 'Tracking',
        targetIndex: 1
      })

      MenuNavigation({
        icon: IconConstants.TRAINING,
        label: 'Trainings',
        targetIndex: 2
      })

      MenuOption({
        icon: IconConstants.SETTINGS,
        label: 'Settings',
        targetIndex: 1
      })

      MenuOption({
        icon: IconConstants.INFO_CIRCLE,
        label: 'About',
        targetIndex: 2
      })
      Blank()
    }
    .padding(SizeConstants.PAD_SCREEN)
  }
}

