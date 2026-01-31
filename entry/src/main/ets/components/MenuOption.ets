@Component
export struct MenuOption {
  @Consume('menuSwiperIndex') menuSwiperIndex: number;

  icon: ResourceStr = '';
  label: string = '';
  targetIndex: number = 0;

  build() {
    Row({ space: 8 }) {
      Image(this.icon)
        .width('32px')
        .aspectRatio(1)
        .fillColor($r('app.color.pure_white'))

      Text(this.label)
        .fontSize($r('app.float.subtitle'))
        .fontColor($r('app.color.pure_white'))

      Blank()

      Image($r('app.media.chevron_down'))
        .width('32px')
        .aspectRatio(1)
        .fillColor($r('app.color.pure_white'))
    }
    .width('100%')
    .padding($r('app.float.pad_small'))
    .onClick(() => {
      this.getUIContext().animateTo({
        duration: 500,
        curve: Curve.EaseInOut
      }, () => {
        this.menuSwiperIndex = this.targetIndex;
      });
    })
  }
}
