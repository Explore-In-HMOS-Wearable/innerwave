// TrainingTimerPage.ets
import { trainingStack } from '../../navigation/TrainingNav';
import { TrainingItem } from '../../model/TrainingItem';
import { CongratzParams } from './TrainingResultView';
import { TrainingViewModel } from '../../viewmodel/TrainingViewModel';
import { TrainingStatsItem } from '../../components/TrainingStatsItem';

@Builder
export function TrainingTimerPageBuilder(): void {
  TrainingTimerPage();
}

@Component
struct TrainingTimerPage {
  @State vm: TrainingViewModel = new TrainingViewModel();

  aboutToAppear(): void {
    const itemParam = this._readItemParam('TrainingTimerPage');
    this.vm.init(itemParam);
    this.vm.onCompleteCallback = () => {
      this._openCongratz();
    };
  }

  aboutToDisappear(): void {
    this.vm.dispose();
  }

  private _readItemParam(pageName: string): TrainingItem | null {
    const params: Object[] = trainingStack.getParamByName(pageName) as Object[];
    if (params.length === 0) {
      return null;
    }

    const v: Object = params[params.length - 1];
    if (v instanceof TrainingItem) {
      return v as TrainingItem;
    }
    return null;
  }

  private _openCongratz(): void {
    trainingStack.pushPath({
      name: 'CongratzPage',
      param: new CongratzParams(
        this.vm.item,
        `${this.vm.steps.length}/${this.vm.steps.length}`,
        this.vm.item.calories,
        this.vm.item.duration
      )
    });
  }

  build() {
    NavDestination() {
      Stack() {
        Column() {
          Text(`${this.vm.stepIndex + 1}/${this.vm.steps.length}`)
            .fontSize($r('app.float.paragraph'))
            .fontColor($r('app.color.tundora'))

          Text(` ${this.vm.currentStepName} `)
            .fontSize($r('app.float.paragraph'))
            .fontColor($r('app.color.scarlet'))

          Text(this.vm.item.title)
            .fontSize($r('app.float.title'))
            .fontColor($r('app.color.international_orange'))
            Row() {
              TrainingStatsItem({
                icon: $r('app.media.bolt'),
                label: 'Difficulty',
                value: this.vm.item.difficulty
              })
              TrainingStatsItem({
                icon: $r('app.media.clock'),
                label: 'Time',
                value: this.vm.getOriginalTimeFormatted()
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)

          Text(this.vm.getDisplayTime())
            .fontSize($r('app.float.hero'))
            .fontColor($r('app.color.pure_white'))
            .fontWeight(FontWeight.Bold)

          Row({ space: $r('app.float.pad_small')}) {
            Button({ type: ButtonType.Capsule }) {
              Image($r('app.media.chevron_left'))
                .fillColor($r('app.color.pure_white'))
                .width('30px')
                .aspectRatio(1)
            }
            .padding($r('app.float.pad_small'))
            .backgroundColor($r('app.color.cod_gray'))
            .onClick(() => {
              trainingStack.pop();
            })

            Button({ type: ButtonType.Capsule }) {
              Image(this.vm.isRunning ? $r('app.media.pause') :
                $r('app.media.play_fill'))
                .fillColor($r('app.color.pure_white'))
                .width('30px')
                .aspectRatio(1)
            }
            .padding($r('app.float.pad_small'))
            .backgroundColor($r('app.color.scarlet'))
            .onClick(() => {
              this.vm.toggleTimer();
            })

            Button({ type: ButtonType.Capsule }) {
              Image($r('app.media.chevron_right'))
                .fillColor($r('app.color.pure_white'))
                .width('30px')
                .aspectRatio(1)
            }
            .padding($r('app.float.pad_small'))
            .backgroundColor($r('app.color.cod_gray'))
            .onClick(() => {
              this.vm.onNextPressed();
            })
          }
        }
        .padding('48px')
        .width('100%')
        .backgroundColor($r('app.color.pure_black'))
        .justifyContent(FlexAlign.SpaceBetween)
        .aspectRatio(1)

        Progress({
          value: this.vm.stepIndex + 1,
          total: this.vm.steps.length,
          type: ProgressType.Ring
        })
          .width('100%')
          .aspectRatio(1)
          .style({
            strokeWidth: '16px',
            enableSmoothEffect: true
          })
          .color($r('app.color.international_orange'))
          .backgroundColor($r('app.color.cod_gray'))
          .hitTestBehavior(HitTestMode.None)
      }
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true);
  }
}