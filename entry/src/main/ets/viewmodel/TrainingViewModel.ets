import { TrainingModel } from '../model/TrainingModel';
import { ExerciseModel } from '../model/ExerciseModel';
import { HeartRateService } from '../services/HeartRateService';
import { VibrationService } from '../services/VibrationService';

export class TrainingViewModel {

  currentHeartRate: number = 0; // HR on timer page
  private hrService: HeartRateService = HeartRateService.getInstance();

  item: TrainingModel = new TrainingModel();

  isRunning: boolean = false;
  stepIndex: number = 0;

  currentTime: number = 0;
  totalTime: number = 30;

  private timerId: number = -1;
  onCompleteCallback: () => void = () => {};

  init(item: TrainingModel) {

    this.item = item;
    this.stepIndex = 0;
    this.isRunning = false;
    this.hrService.startMonitoring((bpm: number) => {
      this.currentHeartRate = bpm;
    });
    this.resetTimerForCurrentStep();
  }

  dispose() {
    this.pauseTimer();
    this.hrService.stopMonitoring();
  }

  get currentStepName(): string {
    if (this.item.exercises.length > this.stepIndex) {
      return this.item.exercises[this.stepIndex].name;
    }
    return 'Done';
  }

  getOriginalTimeFormatted(): string {
    if (this.item.exercises.length > this.stepIndex) {
      return this.item.exercises[this.stepIndex].duration;
    }
    return '00:00';
  }
  getDisplayTime(): string {
    const minutes = Math.floor(this.currentTime / 60);
    const seconds = this.currentTime % 60;
    return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  }

  toggleTimer() {
    if (this.isRunning) {
      this.pauseTimer();
    } else {
      this.startTimer();
    }
  }

  onNextPressed() {
    this.pauseTimer();

    if (this.stepIndex < this.item.exercises.length - 1) {
      this.stepIndex++;
      this.resetTimerForCurrentStep();
    } else {
      this.onCompleteCallback();
    }
  }

  private startTimer() {
    this.isRunning = true;
    this.timerId = setInterval(() => {
      if (this.currentTime > 0) {
        this.currentTime--;
        if(this.currentTime === 10) {
          VibrationService.triggerVibration();
          console.info('TriggerVibrationDeneme')
        }
      } else {
        this.onNextPressed();
      }
    }, 1000);
  }

  private pauseTimer() {
    this.isRunning = false;
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  private resetTimerForCurrentStep() {
    const durationStr = this.item.exercises[this.stepIndex]?.duration || '30s';
    this.currentTime = this.parseDuration(durationStr);
    this.totalTime = this.currentTime;
  }

  private parseDuration(duration: string): number {
    if (duration.includes('min')) {
      const parts = duration.split(' ');
      return parseInt(parts[0]) * 60;
    }
    if (duration.includes('s')) {
      return parseInt(duration.replace('s', '').trim());
    }

    if (duration.includes('reps')) {
      return 45;
    }
    return 30;
  }
}