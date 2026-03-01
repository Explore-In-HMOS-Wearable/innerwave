// TrainingModel.ets
import { util } from '@kit.ArkTS';
import { ExerciseModel } from './ExerciseModel';

export class TrainingModel {
  id: string = util.generateRandomUUID(true);
  name: string = '';
  duration: string = '';
  difficulty: string = 'Medium';
  calories: string = '~0';
  src: string = '';
  thumbnail: Resource = $r('app.media.bolt');
  exercises: Array<ExerciseModel> = [];

  constructor(
    name?: string,
    duration?: string,
    difficulty?: string,
    calories?: string,
    src?: string,
    exercises?: Array<ExerciseModel>,
    thumbnail?: Resource
  ) {
    this.name = name ?? '';
    this.duration = duration ?? '';
    this.difficulty = difficulty ?? 'Medium';
    this.calories = calories ?? '~0';
    this.src = src ?? '';
    this.thumbnail = thumbnail ?? $r('app.media.bolt');
    this.exercises = exercises ?? [];
  }
}