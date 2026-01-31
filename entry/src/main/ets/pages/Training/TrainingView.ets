import { ArcList, ArcListItem, ArcListAttribute } from '@kit.ArkUI';
import { TrainingItem } from '../../model/TrainingItem';
import { getTrainingItems } from '../../model/TrainingData';
import { trainingStack } from '../../navigation/TrainingNav';
import { TrainingRowItem } from '../../components/TrainingRowItem';

@Component
export struct TrainingView {
  @State private trainings: Array<TrainingItem> = getTrainingItems();

  build() {
    Navigation(trainingStack) {
      Stack({ alignContent: Alignment.Top}) {
        Row() {
          Text('Trainings')
            .fontSize($r('app.float.title'))
            .fontColor($r('app.color.international_orange'))
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('80px')
        .backgroundColor($r('app.color.pure_black'))
        .zIndex(1)
        .alignItems(VerticalAlign.Bottom)
        .shadow({
          radius: 16,
          color: $r('app.color.pure_black'),
          offsetX: 0,
          offsetY: 24
        })

        ArcList() {
          ForEach(this.trainings, (item: TrainingItem) => {
            ArcListItem() {
              TrainingRowItem({ item: item })
            }
          }, (item: TrainingItem) => item.key)
        }
        .backgroundColor($r('app.color.pure_black'))
      }
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
  }
}
