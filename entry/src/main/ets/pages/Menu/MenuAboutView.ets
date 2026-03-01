import { MenuAboutItem } from '../../components/MenuAboutItem';
import { ColorConstants } from '../../constants/ColorConstants';
import { SizeConstants } from '../../constants/SizeConstants';

@Component
export struct MenuAboutView {
  build() {
    Column() {
      Text('About')
        .fontSize($r('app.float.title'))
        .fontColor(ColorConstants.INTERNATIONAL_ORANGE)

      Blank()

      MenuAboutItem({
        title: 'Huawei',
        value: 'Innerwave'
      })

      Column() {
        MenuAboutItem({
          title: 'Version',
          value: '0.0.1'
        })

        MenuAboutItem({
          title: 'About',
          value: 'Sample App'
        })

        MenuAboutItem({
          title: 'Privacy',
          value: 'GDPR Compliant'
        })
      }
      .width('100%')

      Blank()
    }
    .width('100%')
    .aspectRatio(1)
    .padding(SizeConstants.PAD_SCREEN)
  }
}
