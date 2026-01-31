import { MenuNavigation } from '../../components/MenuNavigation';
import { MenuOption } from '../../components/MenuOption';

@Component
export struct MenuView {
  @Consume('swiperIndex') swiperIndex: number;
  @Consume('menuSwiperIndex') menuSwiperIndex: number;

  build() {
    Column() {
      Text('Menu')
        .fontSize($r('app.float.title'))
        .fontColor($r('app.color.international_orange'))
      Blank()
      MenuNavigation({
        icon: $r('app.media.tracking'),
        label: 'Tracking',
        targetIndex: 1
      })

      MenuNavigation({
        icon: $r('app.media.training'),
        label: 'Trainings',
        targetIndex: 2
      })

      MenuOption({
        icon: $r('app.media.settings'),
        label: 'Settings',
        targetIndex: 1
      })

      MenuOption({
        icon: $r('app.media.bolt'),
        label: 'About',
        targetIndex: 2
      })
      Blank()
    }
    .padding({
      top: '32px',
      bottom: '32px',
      left: '64px',
      right: '64px'
    })
  }
}

