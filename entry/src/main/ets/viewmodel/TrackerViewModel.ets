import { ActivityModel } from '../model/ActivityData';

@Observed
export class TrackerViewModel {
  selectedIndex: number = 0;
  tempGoal: number = 0;

  data: ActivityModel = {
    dailySteps: 8000,
    dailyStepGoal: 10000,
    weeklySteps: 50000,
    weeklyStepGoal: 70000,
    calories: 123,
    distance: 456,
    heartRate: 789
  };

  public initTempGoal() {
    this.tempGoal = this.selectedIndex === 0 ?
      this.data.dailyStepGoal : this.data.weeklyStepGoal;
  }

  public updateTempGoal(isIncrement: boolean) {
    const step = this.selectedIndex === 0 ? 500 : 5000;
    if (isIncrement) {
      this.tempGoal += step;
    } else if (this.tempGoal > step) {
      this.tempGoal -= step;
    }
  }

  public confirmGoal() {
    const updatedData: ActivityModel = {
      dailySteps: this.data.dailySteps,
      dailyStepGoal: this.selectedIndex === 0 ? this.tempGoal : this.data.dailyStepGoal,
      weeklySteps: this.data.weeklySteps,
      weeklyStepGoal: this.selectedIndex === 1 ? this.tempGoal : this.data.weeklyStepGoal,
      calories: this.data.calories,
      distance: this.data.distance,
      heartRate: this.data.heartRate
    };
    this.data = updatedData;
    console.info(`Goal Updated and UI Synced: ${this.tempGoal}`);
  }

  public get isModified(): boolean {
    const currentGoal = this.selectedIndex === 0 ?
      this.data.dailyStepGoal : this.data.weeklyStepGoal;
    return this.tempGoal !== currentGoal;
  }

  public cancelGoal() {
    this.initTempGoal();
    console.info('Changes Cancelled');
  }

  public getDailyProgress(): number {
    return Math.round((this.data.dailySteps / this.data.dailyStepGoal) * 100);
  }

  public getWeeklyProgress(): number {
    return Math.round((this.data.weeklySteps / this.data.weeklyStepGoal) * 100);
  }
}
