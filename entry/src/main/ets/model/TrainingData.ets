import { TrainingModel } from './TrainingModel';
import { ExerciseModel } from './ExerciseModel';
import { TrainingResponse } from './TrainingResponse';
import { IconConstants } from '../constants/IconConstants';

export function getTrainingData(): TrainingResponse {
  const data = [
    new TrainingModel('Morning Yoga', '10 min', 'Easy', '~150', '', [
      new ExerciseModel(IconConstants.YOGA_GIF, 'Neck Rolls', '30s'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Sun Salutation', '2 min'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Downward Dog', '1 min'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Child Pose', '1 min')
    ], IconConstants.MORNING_YOGA),

    new TrainingModel('Full Body', '25 min', 'Medium', '~220', '', [
      new ExerciseModel(IconConstants.YOGA_GIF, 'Push-Ups', '15 reps'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Squats', '20 reps'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Plank', '45s'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Lunges', '10 reps')
    ], IconConstants.FULL_BODY),

    new TrainingModel('Cardio', '15 min', 'Hard', '~180', '', [
      new ExerciseModel(IconConstants.YOGA_GIF, 'Jumping Jacks', '45s'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'High Knees', '30s'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Mountain Climbers', '30s'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Burpees', '10 reps')
    ], IconConstants.CARDIO),

    new TrainingModel('Mobility', '12 min', 'Easy', '~90', '', [
      new ExerciseModel(IconConstants.YOGA_GIF, 'Hip Circles', '45s'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Shoulder Circles', '45s'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Thoracic Twist', '45s')
    ], IconConstants.MOBILITY),

    new TrainingModel('Stretching', '8 min', 'Easy', '~60', '', [
      new ExerciseModel(IconConstants.YOGA_GIF, 'Hamstring Stretch', '45s'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Quad Stretch', '45s'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Chest Opener', '45s')
    ], IconConstants.STRETCHING),

    new TrainingModel('Core', '14 min', 'Medium', '~90', '', [
      new ExerciseModel(IconConstants.YOGA_GIF, 'Crunches', '20 reps'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Leg Raises', '12 reps'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Russian Twist', '20 reps'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Plank', '45s')
    ], IconConstants.CORE),

    new TrainingModel('Leg Day', '20 min', 'Hard', '~300', '', [
      new ExerciseModel(IconConstants.YOGA_GIF, 'Squats', '20 reps'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Lunges', '12 reps'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Calf Raises', '25 reps'),
      new ExerciseModel(IconConstants.YOGA_GIF, 'Wall Sit', '45s')
    ], IconConstants.LEG)
  ];

  return new TrainingResponse(data);
}