import { MenuAboutItem } from '../../components/MenuAboutItem';

@Component
export struct MenuAboutView {
  build() {
    Column() {
      Text('About')
        .fontSize($r('app.float.title'))
        .fontColor($r('app.color.international_orange'))

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
    .padding({
      top: '32px',
      bottom: '32px',
      left: '64px',
      right: '64px'
    })
  }
}
