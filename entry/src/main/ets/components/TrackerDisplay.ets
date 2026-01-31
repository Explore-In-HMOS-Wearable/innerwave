@Component
export struct TrackerDisplay {
  @Prop title: string = '';
  @Prop subtitle: string = '';

  build() {
    Column() {
      Text(this.title)
        .fontSize($r('app.float.hero'))
        .fontColor($r('app.color.pure_white'))
        .fontWeight(FontWeight.Bolder)

      Text(this.subtitle)
        .fontSize($r('app.float.content'))
        .fontColor($r('app.color.tundora'))
        .fontWeight(FontWeight.Bold)
    }
  }
}