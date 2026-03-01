// TrainingResultView.ets
import { trainingStack } from '../../navigation/TrainingNav';
import { TrainingModel } from '../../model/TrainingModel';
import { common } from '@kit.AbilityKit';
import {AudioService} from '../../services/TrainingMusicService';
import { TrainingStatsItem } from '../../components/TrainingStatsItem';
import { ColorConstants } from '../../constants/ColorConstants';
import { IconConstants } from '../../constants/IconConstants';

export class CongratzParams {
  item: TrainingModel;
  repsText: string;
  caloriesText: string;
  timeText: string;

  constructor(item: TrainingModel, repsText: string, caloriesText: string, timeText: string) {
    this.item = item;
    this.repsText = repsText;
    this.caloriesText = caloriesText;
    this.timeText = timeText;
  }
}

interface TrainingModelDTO {
  name?: string;
  duration?: string;
  difficulty?: string;
  calories?: string;
}

interface CongratzDTO {
  item?: Object;
  repsText?: string;
  caloriesText?: string;
  timeText?: string;
}

@Builder
export function CongratzPageBuilder(): void {
  CongratzPage();
}

const audioService = AudioService.getInstance();

@Component
struct CongratzPage {

  @State item: TrainingModel = new TrainingModel('Training', '0 min', 'Easy', '~0');
  @State repsText: string = '0/0';
  @State caloriesText: string = '~0';
  @State timeText: string = '0m';

  aboutToAppear(): void {
    const ctx = this.getUIContext().getHostContext() as common.UIAbilityContext;
    void audioService.playEmbeddedMp3(ctx, 'congrats_music.mp3');

    const p: Object | null = this._readParam('CongratzPage');
    if (p === null) {
      return;
    }

    if (p instanceof CongratzParams) {
      this.item = p.item;
      this.repsText = p.repsText;
      this.caloriesText = p.caloriesText;
      this.timeText = p.timeText;
      return;
    }

    const dto: CongratzDTO = p as CongratzDTO;

    if (typeof dto.repsText === 'string') {
      this.repsText = dto.repsText;
    }
    if (typeof dto.caloriesText === 'string') {
      this.caloriesText = dto.caloriesText;
    }
    if (typeof dto.timeText === 'string') {
      this.timeText = dto.timeText;
    }

    if (dto.item !== undefined) {
      const it: TrainingModel | null = this._toTrainingModel(dto.item as Object);
      if (it !== null) {
        this.item = it;
      }
    }
    if (this.caloriesText === '~0') {
      this.caloriesText = this.item.calories;
    }
    if (this.timeText === '0m') {
      this.timeText = this.item.duration;
    }
  }

  aboutToDisappear(): void {
    audioService.release();
  }

  private _readParam(pageName: string): Object | null {
    const params: Object[] = trainingStack.getParamByName(pageName) as Object[];
    if (params.length === 0) {
      return null;
    }
    return params[params.length - 1];
  }

  private _goHome(): void {
    trainingStack.pop();
    trainingStack.pop();
    trainingStack.pop();
  }

  build() {
    NavDestination() {
      Stack() {
        Column({ space: 4 }) {
          Text('Congrats!')
            .width('100%')
            .fontSize(18)
            .fontColor(ColorConstants.PURE_WHITE)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center);

          Text(`You have completed the ${this.item.name} training.`)
            .fontSize(12)
            .fontColor(ColorConstants.CHATEAU_GREEN)
            .textAlign(TextAlign.Center)
        }
        .offset({y:-76})
        .height('25%')
        .width('60%')

        Column({ space: 10 }) {
          Row({ space: 6 }) {
            Row({ space: 8 }) {
              TrainingStatsItem({
                icon: IconConstants.BOLT,
                label: 'Reps',
                value: this.repsText
              })

              Text('✓')
                .fontSize(18)
                .fontColor(ColorConstants.PURE_WHITE)
                .opacity(0.85)
                .fontWeight(FontWeight.Bold)
            }
            .width('50%')
            .justifyContent(FlexAlign.Center)

            Row({ space: 8 }) {
              TrainingStatsItem({
                icon: IconConstants.SUN_MAX,
                label: 'Calories',
                value: this.caloriesText
              }).offset({x:-10})

              Text('✓')
                .fontSize(18)
                .fontColor(ColorConstants.PURE_WHITE)
                .opacity(0.85)
                .fontWeight(FontWeight.Bold)
            }
            .width('50%')
            .justifyContent(FlexAlign.Center)
          }
          .backgroundColor(Color.Black)
          .width('100%')

          Row({ space: 8 }) {
            TrainingStatsItem({
              icon: IconConstants.CLOCK,
              label: 'Time',
              value: this.timeText
            })

            Text('✓')
              .fontSize(18)
              .fontColor(ColorConstants.PURE_WHITE)
              .opacity(0.85)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .offset({ y: 10 })
        .backgroundColor(ColorConstants.PURE_BLACK)

        Column() {
          Button() {
            Text('Home')
              .fontSize(14)
              .fontColor(ColorConstants.PURE_WHITE)
              .fontWeight(FontWeight.Bold);
          }
          .width(100)
          .height(26)
          .borderRadius(20)
          .backgroundColor(Color.Green)
          .onClick(() => this._goHome());
        }
        .offset({y:83})
      }
      .backgroundColor(ColorConstants.PURE_BLACK)
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true);
  }

  private _toTrainingModel(v: Object): TrainingModel | null {
    if (v instanceof TrainingModel) {
      return v as TrainingModel;
    }

    const o: TrainingModelDTO = v as TrainingModelDTO;

    if (typeof o.name === 'string' && typeof o.duration === 'string') {
      const diff = (typeof o.difficulty === 'string') ? o.difficulty : 'Easy';
      const cal = (typeof o.calories === 'string') ? o.calories : '~0';
      return new TrainingModel(o.name, o.duration, diff, cal);
    }
    return null;
  }
}