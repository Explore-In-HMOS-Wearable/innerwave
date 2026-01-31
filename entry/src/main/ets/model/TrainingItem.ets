import { util } from '@kit.ArkTS';

export class TrainingItem {
  key: string = util.generateRandomUUID(true);

  id: string;
  title: string;
  duration: string;
  difficulty: string;
  calories: string;

  constructor(id: string, title: string, duration: string, difficulty: string, calories: string) {
    this.id = id;
    this.title = title;
    this.duration = duration;
    this.difficulty = difficulty;
    this.calories = calories;
  }
}
