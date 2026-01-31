@Component
export struct TrackerHeader {
  @Prop title: string;
  @Prop imagePath: Resource;
  @Prop iconColor: Resource;

  build() {
    Column({ space: $r('app.float.pad_mini') }) {
      Image(this.imagePath)
        .width('36px')
        .aspectRatio(1)
        .fillColor(this.iconColor)

      Text(this.title)
        .fontSize($r('app.float.paragraph'))
        .fontColor($r('app.color.pure_white'))
    }
  }
}
