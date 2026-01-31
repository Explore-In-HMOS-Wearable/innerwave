@Component
export struct TrackerStatCard {
  @Prop value: string = '';
  @Prop unit: string = '';
  @Prop icon: Resource;
  @Prop iconColor: ResourceColor = '#FFFFFF';

  build() {
    Column() {
      Image(this.icon)
        .width('32px')
        .aspectRatio(1)
        .fillColor(this.iconColor)
        .objectFit(ImageFit.Contain)

      Blank()
        .height($r('app.float.pad_mini'))

      Text(this.value)
        .fontSize($r('app.float.subtitle'))
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.pure_white'))

      Text(this.unit)
        .fontSize($r('app.float.paragraph'))
        .fontColor($r('app.color.tundora'))
    }
  }
}
