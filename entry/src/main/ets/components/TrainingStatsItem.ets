@Component
export struct TrainingStatsItem {
  icon: Resource = $r('app.media.bolt');
  label: string = '';
  value: string = '';

  build() {
    Row({ space: $r('app.float.pad_mini') }) {
      Image(this.icon)
        .width('48px')
        .aspectRatio(1)
        .fillColor($r('app.color.pure_white'))
        .objectFit(ImageFit.Contain)

      Column() {
        Text(this.label)
          .fontSize($r('app.float.paragraph'))
          .fontColor($r('app.color.tundora'))

        Text(this.value)
          .fontSize($r('app.float.content'))
          .fontColor($r('app.color.pure_white'))
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}