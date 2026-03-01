import { ExerciseModel } from '../../model/ExerciseModel';

@Component
export struct ExerciseBackgroundView {
  @Prop currentExercise: ExerciseModel;

  build() {
    Stack() {
      Image(this.currentExercise.imageSrc)
        .width('50%')
        .height('50%')
        .objectFit(ImageFit.Cover)
        .opacity(0.1)
    }
    .backgroundColor(Color.Red)
    .width('100%')
    .height('100%')
    .clipShape(new Circle({ width: '100%', height: '100%' }))
  }
}