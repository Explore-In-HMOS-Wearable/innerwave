import { trainingStack } from '../../navigation/TrainingNav';
import { TrainingItem } from '../../model/TrainingItem';
import { TrainingStatsRow } from '../../components/TrainingStatsRow';
import { TrainingActionButtons } from '../../components/TrainingActionButton';

@Builder
export function TrainingDetailPageBuilder(): void {
  TrainingDetailView();
}

@Component
struct TrainingDetailView {
  @State item: TrainingItem = new TrainingItem('training', 'Training', '0 min', 'Easy', '~0');

  aboutToAppear() {
    const it: TrainingItem | null = this._readItemParam('TrainingDetailPage');
    if (it !== null) {
      this.item = it;
    }
  }

  private _readItemParam(pageName: string): TrainingItem | null {
    const params: Object[] = trainingStack.getParamByName(pageName) as Object[];
    if (params.length === 0) {
      return null;
    }
    const v: Object = params[params.length - 1];
    return v instanceof TrainingItem ? v : null;
  }

  build() {
    NavDestination() {
      Column() {
        Text(this.item.title)
          .fontSize($r('app.float.headline'))
          .fontColor($r('app.color.pure_white'))
          .fontWeight(FontWeight.Bold)

        TrainingStatsRow({ item: this.item })

        TrainingActionButtons({
          item: this.item,
          onBack: () => trainingStack.pop()
        })
      }
      .backgroundColor($r('app.color.pure_black'))
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .aspectRatio(1)
      .padding({
        top: '64px',
        bottom: '64px'
      })
    }
    .hideTitleBar(true)
    .hideBackButton(true)
  }
}
