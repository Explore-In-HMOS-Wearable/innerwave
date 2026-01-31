// TrainingResultView.ets
import { trainingStack } from '../../navigation/TrainingNav';
import { TrainingItem } from '../../model/TrainingItem';
import { common } from '@kit.AbilityKit';
import {AudioService} from '../../services/TrainingMusicService';
import { TrainingStatsItem } from '../../components/TrainingStatsItem';

export class CongratzParams {
  item: TrainingItem;
  repsText: string;
  caloriesText: string;
  timeText: string;

  constructor(item: TrainingItem, repsText: string, caloriesText: string, timeText: string) {
    this.item = item;
    this.repsText = repsText;
    this.caloriesText = caloriesText;
    this.timeText = timeText;
  }
}

interface TrainingItemDTO {
  title?: string;
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
// For mp3 media, Singleton Pattern
const audioService = AudioService.getInstance();

@Component
struct CongratzPage {

  @State item: TrainingItem = new TrainingItem('training', 'Training', '0 min', 'Easy', '~0');
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
      const it: TrainingItem | null = this._toTrainingItem(dto.item as Object);
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
            .fontColor($r('app.color.pure_white'))
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center);

          Text(`You have completed the ${this.item.title} training.`)
            //.width('100%')
            .fontSize(12)
            .fontColor($r('app.color.chateau_green'))
            .textAlign(TextAlign.Center)
            //.maxLines(2);
        }
        .offset({y:-76})
        .height('25%')
        .width('60%')

        Column({ space: 10 }) {
          Row({ space: 6 }) {
            Row({ space: 8 }) {
              TrainingStatsItem({
                icon: $r('app.media.bolt'),
                label: 'Reps',
                value: this.repsText
              })

              Text('✓')
                .fontSize(18)
                .fontColor($r('app.color.pure_white'))
                .opacity(0.85)
                .fontWeight(FontWeight.Bold)
            }
            .width('50%')
            .justifyContent(FlexAlign.Center)

            Row({ space: 8 }) {
              TrainingStatsItem({
                icon: $r('app.media.sun_max'),
                label: 'Calories',
                value: this.caloriesText
              }).offset({x:-10})

              Text('✓')
                .fontSize(18)
                .fontColor($r('app.color.pure_white'))
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
              icon: $r('app.media.clock'),
              label: 'Time',
              value: this.timeText
            })

            Text('✓')
              .fontSize(18)
              .fontColor($r('app.color.pure_white'))
              .opacity(0.85)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .offset({ y: 10 })
        .backgroundColor($r('app.color.pure_black'))

        Column() {
          Button() {
            Text('Home')
              .fontSize(14)
              .fontColor($r('app.color.pure_white'))
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
      .backgroundColor($r('app.color.pure_black'))
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true);
  }

  private _toTrainingItem(v: Object): TrainingItem | null {
    if (v instanceof TrainingItem) {
      return v as TrainingItem;
    }

    const o: TrainingItemDTO = v as TrainingItemDTO;
    if (typeof o.title === 'string' && typeof o.duration === 'string') {
      const diff = (typeof o.difficulty === 'string') ? o.difficulty : 'Easy';
      const cal = (typeof o.calories === 'string') ? o.calories : '~0';
      const id = toTrainingId(o.title);
      return new TrainingItem(id, o.title, o.duration, diff, cal);

    }
    return null;
  }
}

function toTrainingId(title: string): string {
  const trimmed = title.trim();
  if (trimmed.length === 0) {
    return 'training';
  }
  const words = trimmed.split(/\s+/);
  return words[0].toLowerCase() + words.slice(1).map(w => w.charAt(0).toUpperCase() + w.slice(1)).join('');
}
