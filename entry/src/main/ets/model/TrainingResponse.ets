import { TrainingModel } from './TrainingModel';

export class TrainingResponse {
  trainings: Array<TrainingModel> = [];

  constructor(trainings?: Array<TrainingModel>) {
    this.trainings = trainings ?? [];
  }
}