import 'package:equatable/equatable.dart';
import '../models/exercise.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object?> get props => [];
}

class LoadWorkout extends WorkoutEvent {
  const LoadWorkout();
}

class SelectExercise extends WorkoutEvent {
  final int exerciseIndex;

  const SelectExercise(this.exerciseIndex);

  @override
  List<Object?> get props => [exerciseIndex];
}

class UpdateExerciseStatus extends WorkoutEvent {
  final String exerciseName;
  final String status;

  const UpdateExerciseStatus(this.exerciseName, this.status);

  @override
  List<Object?> get props => [exerciseName, status];
}

class EnterEditMode extends WorkoutEvent {
  const EnterEditMode();
}

class ExitEditMode extends WorkoutEvent {
  const ExitEditMode();
}

class ReorderExercises extends WorkoutEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderExercises(this.oldIndex, this.newIndex);

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class RemoveExercise extends WorkoutEvent {
  final int exerciseIndex;

  const RemoveExercise(this.exerciseIndex);

  @override
  List<Object?> get props => [exerciseIndex];
}

class SaveChanges extends WorkoutEvent {
  const SaveChanges();
}

class DiscardChanges extends WorkoutEvent {
  const DiscardChanges();
}

class AddExercise extends WorkoutEvent {
  final Exercise exercise;

  const AddExercise(this.exercise);

  @override
  List<Object?> get props => [exercise];
}
