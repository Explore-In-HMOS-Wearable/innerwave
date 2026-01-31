@Component
export struct TrackerGoal {
  @Prop goal: number = 0;
  @Prop progress: number = 0;
  @Prop color: Resource;

  build() {
    Column({ space: $r('app.float.pad_mini') }) {
      Text(`Goal: ${this.goal}`)
        .fontSize($r('app.float.paragraph'))
        .fontColor($r('app.color.pure_white'))

      Text(`${this.progress}% Completed`)
        .fontSize($r('app.float.content'))
        .fontColor(this.color)
    }
  }
}