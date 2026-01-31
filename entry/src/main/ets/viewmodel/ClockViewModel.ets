@Observed
export class ClockViewModel {
  @Track public currentTime: string = '00:00';
  @Track public seconds: string = '00';
  @Track public amPm: string = 'AM';
  @Track public fullDate: string = '';

  private timerId: number = -1;

  constructor() {
    this.startClock();
  }

  public startClock() {
    this._updateTime();
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
    }
    this.timerId = setInterval(() => {
      this._updateTime();
    }, 1000);
  }

  public stopClock() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  private _updateTime() {
    const now = new Date();

    let hours = now.getHours();
    const minutes = now.getMinutes();
    const secs = now.getSeconds();

    this.amPm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? hours : 12;

    this.currentTime = `${this._pad(hours)}:${this._pad(minutes)}`;
    this.seconds = this._pad(secs);

    this.fullDate = new Intl.DateTimeFormat('tr-TR', {
      day: 'numeric',
      month: 'long',
      year: 'numeric'
    }).format(now);
  }

  private _pad(num: number): string {
    return num < 10 ? `0${num}` : `${num}`;
  }
}
