import 'package:equatable/equatable.dart';
import '../models/exercise.dart';
import '../models/workout.dart';

enum WorkoutStatus { initial, loading, loaded, error }

class WorkoutState extends Equatable {
  final WorkoutStatus status;
  final Workout? workout;
  final List<Exercise> exercises;
  final int selectedExerciseIndex;
  final bool isEditMode;
  final List<Exercise>? originalExercises; // For discarding changes
  final String? errorMessage;
  final bool hasUnsavedChanges;

  const WorkoutState({
    this.status = WorkoutStatus.initial,
    this.workout,
    this.exercises = const [],
    this.selectedExerciseIndex = 0,
    this.isEditMode = false,
    this.originalExercises,
    this.errorMessage,
    this.hasUnsavedChanges = false,
  });

  WorkoutState copyWith({
    WorkoutStatus? status,
    Workout? workout,
    List<Exercise>? exercises,
    int? selectedExerciseIndex,
    bool? isEditMode,
    List<Exercise>? originalExercises,
    String? errorMessage,
    bool? hasUnsavedChanges,
  }) {
    return WorkoutState(
      status: status ?? this.status,
      workout: workout ?? this.workout,
      exercises: exercises ?? this.exercises,
      selectedExerciseIndex:
          selectedExerciseIndex ?? this.selectedExerciseIndex,
      isEditMode: isEditMode ?? this.isEditMode,
      originalExercises: originalExercises ?? this.originalExercises,
      errorMessage: errorMessage ?? this.errorMessage,
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
    );
  }

  Exercise? get selectedExercise {
    if (exercises.isEmpty || selectedExerciseIndex >= exercises.length) {
      return null;
    }
    return exercises[selectedExerciseIndex];
  }

  bool get canSaveChanges => hasUnsavedChanges && isEditMode;

  @override
  List<Object?> get props => [
    status,
    workout,
    exercises,
    selectedExerciseIndex,
    isEditMode,
    originalExercises,
    errorMessage,
    hasUnsavedChanges,
  ];
}
