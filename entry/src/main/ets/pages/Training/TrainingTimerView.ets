// TrainingTimerView.ets
import { trainingStack } from '../../navigation/TrainingNav';
import { TrainingModel } from '../../model/TrainingModel';
import { CongratzParams } from './TrainingResultView';
import { TrainingViewModel } from '../../viewmodel/TrainingViewModel';
import { ExerciseBackgroundView } from './ExerciseBackgroundView';
import { ColorConstants } from '../../constants/ColorConstants';
import { IconConstants } from '../../constants/IconConstants';
import { SizeConstants } from '../../constants/SizeConstants';


@Builder
export function TrainingTimerPageBuilder(): void {
  TrainingTimerPage();
}

@Component
struct TrainingTimerPage {
  
  @State vm: TrainingViewModel = new TrainingViewModel();
  
  aboutToAppear(): void {
    const itemParam = this._readItemParam('TrainingTimerPage');
    if (itemParam) {
      this.vm.init(itemParam);
    }
    this.vm.onCompleteCallback = () => {
      this._openCongratz();
    };
  }
  
  aboutToDisappear(): void {
    this.vm.dispose();
  }
  
  private _readItemParam(pageName: string): TrainingModel | null {
    const params: Object[] = trainingStack.getParamByName(pageName) as Object[];
    if (params.length === 0) {
      return null;
    }

    const v: Object = params[params.length - 1];
    if (v instanceof TrainingModel) {
      return v as TrainingModel;
    }
    return null;
  }
  
  private _openCongratz(): void {
    trainingStack.pushPath({
      name: 'CongratzPage',
      param: new CongratzParams(
        this.vm.item,
        `${this.vm.item.exercises.length}/${this.vm.item.exercises.length}`,
        this.vm.item.calories,
        this.vm.item.duration
      )
    });
  }

  build() {
    NavDestination() {
      Stack() {
          Column() {
            Text(`${this.vm.stepIndex + 1}/${this.vm.item.exercises.length}`)
              .fontSize($r('app.float.paragraph'))
              .fontColor(ColorConstants.TUNDORA)

            Text(` ${this.vm.currentStepName} `)
              .fontSize($r('app.float.paragraph'))
              .fontColor(ColorConstants.SCARLET)

            Text(this.vm.item.name)
              .fontSize($r('app.float.title'))
              .fontColor(ColorConstants.INTERNATIONAL_ORANGE)
            Row() {
              Image(IconConstants.HEART_FILL)
                .fillColor(ColorConstants.PURE_WHITE)
                .width('40px')

              Text('HR')
                .fontSize($r('app.float.content'))
                .fontWeight(FontWeight.Bold)

              Text(this.vm.currentHeartRate > 0 ? ` ${this.vm.currentHeartRate}` : ' --')
                .fontSize($r('app.float.content'))
                .fontWeight(FontWeight.Bold)
                .fontColor(ColorConstants.INTERNATIONAL_ORANGE)
                .animation({ duration: 300 })
            }
            .width('40%')
            .justifyContent(FlexAlign.SpaceEvenly)

            if (this.vm.item.exercises.length > 0) {
              Image(this.vm.item.exercises[this.vm.stepIndex].imageSrc)
                .height('60')
                .objectFit(ImageFit.Contain)
                .fillColor(ColorConstants.PURE_WHITE)
            }

            Text(this.vm.getDisplayTime())
              .fontSize($r('app.float.headline'))
              .fontColor(ColorConstants.PURE_WHITE)
              .fontWeight(FontWeight.Bold)

            Row({ space: SizeConstants.PAD_SMALL }) {
              Button({ type: ButtonType.Capsule }) {
                Image(IconConstants.CHEVRON_LEFT)
                  .fillColor(ColorConstants.PURE_WHITE)
                  .width('30px')
                  .aspectRatio(1)
              }
              .padding(SizeConstants.PAD_SMALL)
              .backgroundColor(ColorConstants.COD_GRAY)
              .onClick(() => {
                trainingStack.pop();
              })

              Button({ type: ButtonType.Capsule }) {
                Image(this.vm.isRunning ? IconConstants.PAUSE : IconConstants.PLAY_FILL)
                  .fillColor(ColorConstants.PURE_WHITE)
                  .width('30px')
                  .aspectRatio(1)
              }
              .padding(SizeConstants.PAD_SMALL)
              .backgroundColor(ColorConstants.SCARLET)
              .onClick(() => {
                this.vm.toggleTimer();
              })

              Button({ type: ButtonType.Capsule }) {
                Image(IconConstants.CHEVRON_RIGHT)
                  .fillColor(ColorConstants.PURE_WHITE)
                  .width('30px')
                  .aspectRatio(1)
              }
              .padding(SizeConstants.PAD_SMALL)
              .backgroundColor(ColorConstants.COD_GRAY)
              .onClick(() => {
                this.vm.onNextPressed();
              })
            }
          }
          .padding(SizeConstants.PAD_XL)
          .width('100%')
          .backgroundColor(ColorConstants.PURE_BLACK)
          .justifyContent(FlexAlign.SpaceBetween)
          .aspectRatio(1)

        Progress({
          value: this.vm.stepIndex + 1,
          total: this.vm.item.exercises.length,
          type: ProgressType.Ring
        })
          .width('100%')
          .aspectRatio(1)
          .style({
            strokeWidth: '16px',
            enableSmoothEffect: true
          })
          .color(ColorConstants.INTERNATIONAL_ORANGE)
          .backgroundColor(ColorConstants.COD_GRAY)
          .hitTestBehavior(HitTestMode.None)
      }
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true);
  }
}