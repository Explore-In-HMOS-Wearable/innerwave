import { TrainingItem } from './TrainingItem';

export function getTrainingItems(): Array<TrainingItem> {
  return [
    new TrainingItem('morningYoga', 'Morning Yoga', '10 min', 'Easy', '~150'),
    new TrainingItem('fullBody', 'Full Body', '25 min', 'Medium', '~220'),
    new TrainingItem('cardio', 'Cardio', '15 min', 'Hard', '~180'),
    new TrainingItem('mobility', 'Mobility', '12 min', 'Easy', '~90'),
    new TrainingItem('stretching', 'Stretching', '8 min', 'Easy', '~60'),
    new TrainingItem('core', 'Core', '14 min', 'Medium', '~90'),
    new TrainingItem('legDay', 'Leg Day', '20 min', 'Hard', '~300')
  ];
}

const TRAINING_STEPS: Map<string, Array<string>> = new Map<string, Array<string>>([
  ['morningYoga', ['Neck Rolls', 'Sun Salutation', 'Downward Dog', 'Child Pose']],
  ['fullBody', ['Push-Ups', 'Squats', 'Plank', 'Lunges']],
  ['cardio', ['Jumping Jacks', 'High Knees', 'Mountain Climbers', 'Burpees']],
  ['mobility', ['Hip Circles', 'Shoulder Circles', 'Thoracic Twist']],
  ['stretching', ['Hamstring Stretch', 'Quad Stretch', 'Chest Opener']],
  ['core', ['Crunches', 'Leg Raises', 'Russian Twist', 'Plank']],
  ['legDay', ['Squats', 'Lunges', 'Calf Raises', 'Wall Sit']]
]);

export function getTrainingSteps(trainingId: string): Array<string> {
  const steps = TRAINING_STEPS.get(trainingId);
  if (steps && steps.length > 0) {
    return steps;
  }
  return ['Warm-Up', 'Main Set', 'Cool Down'];
}
