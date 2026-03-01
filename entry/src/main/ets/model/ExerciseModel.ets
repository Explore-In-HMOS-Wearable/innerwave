import { util } from '@kit.ArkTS';

export class ExerciseModel {
  id: string = util.generateRandomUUID(true);
  name: string = '';
  duration: string = '';
  src: string = '';
  imageSrc: Resource; // todo for gif

  constructor(imageSrc: Resource, name?: string, duration?: string, src?: string) { // todo for gif
    this.name = name ?? '';
    this.duration = duration ?? '';
    this.src = src ?? '';
    this.imageSrc = imageSrc;
  }
}