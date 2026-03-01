// TrainingView.ets
import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute } from '@kit.ArkUI';
import { ColorConstants } from '../../constants/ColorConstants';
import { TrainingModel } from '../../model/TrainingModel';
import { getTrainingData } from '../../model/TrainingData';
import { trainingStack } from '../../navigation/TrainingNav';
import { TrainingRowItem } from '../../components/TrainingRowItem';

import { WearEngineService } from '../../services/WearEngineService';
import { common } from '@kit.AbilityKit';

@Component
export struct TrainingView {
  @State private trainings: Array<TrainingModel> = getTrainingData().trainings;
  @State private usingPhoneData: boolean = false;

  private hub: WearEngineService = WearEngineService.getInstance();

  aboutToAppear(): void {
    const ctx = this.getUIContext().getHostContext() as common.Context;

    this.hub.init(ctx);
    this.hub.setPhonePeerConfig({
      phoneBundleName: 'PHONE_BUNDLE_NAME_HERE',
      phoneFingerprint: 'PHONE_FINGERPRINT_HERE',
      transformLocal: false
    });

    this.hub.onTrainings = (list: Array<TrainingModel>) => {
      if (list.length > 0) {
        this.trainings = list;
        this.usingPhoneData = true;
      }
    };

    this.hub.startListening().catch(() => {
    });
  }

  aboutToDisappear(): void {
    this.hub.onTrainings = null;
    this.hub.onTextMessage = null;
    this.hub.stopListening().catch(() => {});
  }

  build() {
    Navigation(trainingStack) {
      Stack({ alignContent: Alignment.Top }) {
        Row() {
          Text('Trainings')
            .fontSize($r('app.float.title'))
            .fontColor(ColorConstants.INTERNATIONAL_ORANGE)

          if (this.usingPhoneData) {
            Text('  PHONE')
              .fontSize(12)
              .fontColor(ColorConstants.CHATEAU_GREEN)
              .opacity(0.9)
          } else {
            Text('  MOCK')
              .fontSize(12)
              .fontColor(ColorConstants.TUNDORA)
              .opacity(0.9)
          }
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('80px')
        .backgroundColor(ColorConstants.PURE_BLACK)
        .zIndex(1)
        .alignItems(VerticalAlign.Bottom)
        .shadow({
          radius: 16,
          color: ColorConstants.PURE_BLACK,
          offsetX: 0,
          offsetY: 24
        })

        ArcList() {
          ForEach(this.trainings, (item: TrainingModel) => {
            ArcListItem() {
              TrainingRowItem({ item: item })
            }
            .onClick(() => {
              trainingStack.pushPath({ name: 'TrainingDetailPage', param: item });
            })
          }, (item: TrainingModel) => item.id)
        }
        .backgroundColor(ColorConstants.PURE_BLACK)
      }
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
  }
}