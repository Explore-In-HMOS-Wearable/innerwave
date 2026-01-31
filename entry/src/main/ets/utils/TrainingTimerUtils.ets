export class TrainingTimeUtils {

  static parseDurationToSeconds(duration: string): number {
    const s = (duration ?? '').trim().toLowerCase();

    const mmss = /^(\d{1,2})\s*:\s*(\d{2})$/.exec(s);
    if (mmss) {
      const m = Number(mmss[1]);
      const sec = Number(mmss[2]);
      return Math.max(0, m * 60 + sec);
    }

    const minRegex = /(\d+)\s*(m|min)/;
    const minMatch = minRegex.exec(s);
    if (minMatch) {
      const m = Number(minMatch[1]);
      return Math.max(0, m * 60);
    }

    return 0;
  }

  static formatMMSS(totalSec: number): string {
    const t = Math.max(0, Math.floor(totalSec));
    const m = Math.floor(t / 60);
    const s = t % 60;
    const ss = s < 10 ? `0${s}` : `${s}`;
    return `${m}:${ss}`;
  }
}