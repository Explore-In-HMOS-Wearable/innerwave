// TrainingDetailView.ets
import { trainingStack } from '../../navigation/TrainingNav';
import { TrainingModel } from '../../model/TrainingModel';
import { TrainingStatsRow } from '../../components/TrainingStatsRow';
import { TrainingActionButtons } from '../../components/TrainingActionButton';
import { ColorConstants } from '../../constants/ColorConstants';
import { SizeConstants } from '../../constants/SizeConstants';

@Builder
export function TrainingDetailPageBuilder(): void {
  TrainingDetailView();
}

@Component
struct TrainingDetailView {
  @State item: TrainingModel = new TrainingModel();

  aboutToAppear() {
    const it: TrainingModel | null = this._readItemParam('TrainingDetailPage');
    if (it !== null) {
      this.item = it;
    }
  }

  private _readItemParam(pageName: string): TrainingModel | null {
    const params: Object[] = trainingStack.getParamByName(pageName) as Object[];
    if (params.length === 0) {
      return null;
    }
    const v: Object = params[params.length - 1];

    return v instanceof TrainingModel ? v : null;
  }

  build() {
    NavDestination() {
      Column() {
        Text(this.item.name)
          .fontSize($r('app.float.headline'))
          .fontColor(ColorConstants.PURE_WHITE)
          .fontWeight(FontWeight.Bold)

        TrainingStatsRow({ item: this.item })

        TrainingActionButtons({
          item: this.item,
          onBack: () => trainingStack.pop()
        })
      }
      .backgroundColor(ColorConstants.PURE_BLACK)
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .aspectRatio(1)
      .padding(SizeConstants.PAD_VERTICAL_XXL)
    }
    .hideTitleBar(true)
    .hideBackButton(true)
  }
}