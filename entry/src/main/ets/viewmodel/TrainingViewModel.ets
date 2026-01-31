import { TrainingItem } from '../model/TrainingItem';
import { getTrainingSteps } from '../model/TrainingData';
import { TrainingTimeUtils } from '../utils/TrainingTimerUtils';

@Observed
export class TrainingViewModel {

  public showDone: boolean = false;
  public showNext: boolean = false;
  public isRunning: boolean = false;
  public sessionStarted: boolean = false;

  public item: TrainingItem = new TrainingItem('training', 'Training', '0 min', 'Easy', '~0');
  public steps: Array<string> = [];
  public currentStepName: string = 'Placeholder';

  public totalSeconds: number = 0;
  public stepIndex: number = 0;
  public stepRemaining: number = 0;

  private originalTotalSeconds: number = 0;
  private stepSeconds: number = 0;
  private timerId: number = -1;
  private readonly DEBUG_STEP_SEC: number = 10;
  public onCompleteCallback?: () => void;

  public init(item: TrainingItem | null): void {
    this._stopTimer();
    if (item) {
      this.item = item;
    }
    this._resetState();
    this.steps = getTrainingSteps(this.item.title);
    this._updateStepName();
    this._startTimer();
  }

  public dispose(): void {
    this._stopTimer();
  }

  public toggleTimer(): void {
    if (this.showNext) {
      return;
    }

    if (this.isRunning) {
      this._stopTimer();
    } else {
      this._startTimer();
    }
  }

  public onNextPressed(): void {
    if (!this.sessionStarted) {
      return;
    }

    if (this.stepIndex < this.steps.length - 1) {
      this.stepIndex++;
      this._updateStepName();
      this.stepRemaining = this.stepSeconds;
      this.showNext = false;
      this._startTimer();
    } else {
      this._finishSession();
    }
  }

  private _resetState(): void {
    this.originalTotalSeconds = 0;
    this.totalSeconds = 0;
    this.stepIndex = 0;
    this.stepSeconds = 0;
    this.stepRemaining = 0;
    this.sessionStarted = false;
    this.showNext = false;
    this.showDone = false;

    if (this.steps.length > 0) {
      this.currentStepName = this.steps[0];
    }
  }

  private _startSessionIfNeeded(): void {
    if (this.sessionStarted) {
      return;
    }

    this.steps = getTrainingSteps(this.item.title);
    this.stepIndex = 0;
    this._updateStepName();

    if (this.DEBUG_STEP_SEC > 0) {
      this.stepSeconds = this.DEBUG_STEP_SEC;
      this.stepRemaining = this.stepSeconds;
      this.originalTotalSeconds = this.steps.length * this.stepSeconds;
      this.totalSeconds = this.originalTotalSeconds;
    } else {
      this.originalTotalSeconds = TrainingTimeUtils.parseDurationToSeconds(this.item.duration);
      this.totalSeconds = this.originalTotalSeconds;

      const n = Math.max(1, this.steps.length);
      const per = Math.floor(this.originalTotalSeconds / n);
      this.stepSeconds = Math.max(5, per);
      this.stepRemaining = this.stepSeconds;
    }

    this.sessionStarted = true;
    this.showNext = false;
  }

  private _startTimer(): void {
    if (this.showDone || this.showNext || this.isRunning) {
      return;
    }

    this._startSessionIfNeeded();

    if (this.totalSeconds <= 0) {
      return;
    }

    this.isRunning = true;

    this.timerId = setInterval(() => {
      if (!this.isRunning) {
        return;
      }

      if (this.totalSeconds > 0) {
        this.totalSeconds--;
      }

      if (this.sessionStarted && this.stepRemaining > 0) {
        this.stepRemaining--;

        if (this.stepRemaining <= 0) {
          this._handleStepCompilaton();
        }
      }

      if (this.totalSeconds <= 0) {
        this._finishSession();
      }
    }, 1000) as number;
  }

  private _handleStepCompilaton(): void {
    this.stepRemaining = 0;

    if (this.stepIndex < this.steps.length - 1) {
      this.showNext = true;
      this._stopTimer();
    } else {
      this._finishSession();
    }
  }

  private _finishSession(): void {
    this.totalSeconds = 0;
    this.showNext = false;
    this.showDone = true;
    this._stopTimer();

    if (this.onCompleteCallback) {
      this.onCompleteCallback();
    }
  }

  private _stopTimer(): void {
    this.isRunning = false;
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  private _updateStepName(): void {
    if (this.steps.length > this.stepIndex) {
      this.currentStepName = this.steps[this.stepIndex];
    }
  }

  public getDisplayTime(): string {
    return TrainingTimeUtils.formatMMSS(
      this.sessionStarted ? this.stepRemaining : this.totalSeconds
    );
  }

  public getOriginalTimeFormatted(): string {
    return TrainingTimeUtils.formatMMSS(
      this.sessionStarted ? this.totalSeconds :
        TrainingTimeUtils.parseDurationToSeconds(this.item.duration)
    );
  }
}