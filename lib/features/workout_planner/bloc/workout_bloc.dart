import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../models/exercise.dart';
import '../repository/workout_repository.dart';
import 'workout_event.dart';
import 'workout_state.dart';

@injectable
class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutRepository _workoutRepository;

  WorkoutBloc(this._workoutRepository) : super(const WorkoutState()) {
    on<LoadWorkout>(_onLoadWorkout);
    on<SelectExercise>(_onSelectExercise);
    on<UpdateExerciseStatus>(_onUpdateExerciseStatus);
    on<EnterEditMode>(_onEnterEditMode);
    on<ExitEditMode>(_onExitEditMode);
    on<ReorderExercises>(_onReorderExercises);
    on<RemoveExercise>(_onRemoveExercise);
    on<SaveChanges>(_onSaveChanges);
    on<DiscardChanges>(_onDiscardChanges);
    on<AddExercise>(_onAddExercise);
  }

  Future<void> _onLoadWorkout(
    LoadWorkout event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(state.copyWith(status: WorkoutStatus.loading));

    try {
      final workout = await _workoutRepository.getWorkout();
      final sortedExercises = List<Exercise>.from(workout.exercises)
        ..sort((a, b) => a.order.compareTo(b.order));

      emit(
        state.copyWith(
          status: WorkoutStatus.loaded,
          workout: workout,
          exercises: sortedExercises,
          selectedExerciseIndex: _findCurrentExerciseIndex(sortedExercises),
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: WorkoutStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void _onSelectExercise(SelectExercise event, Emitter<WorkoutState> emit) {
    if (event.exerciseIndex >= 0 &&
        event.exerciseIndex < state.exercises.length &&
        !state.isEditMode) {
      emit(state.copyWith(selectedExerciseIndex: event.exerciseIndex));
    }
  }

  Future<void> _onUpdateExerciseStatus(
    UpdateExerciseStatus event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      await _workoutRepository.updateExerciseStatus(
        event.exerciseName,
        event.status,
      );

      final updatedExercises = state.exercises.map((exercise) {
        if (exercise.name == event.exerciseName) {
          return exercise.copyWith(status: event.status);
        }
        return exercise;
      }).toList();

      emit(state.copyWith(exercises: updatedExercises));
    } catch (e) {
      emit(
        state.copyWith(status: WorkoutStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void _onEnterEditMode(EnterEditMode event, Emitter<WorkoutState> emit) {
    emit(
      state.copyWith(
        isEditMode: true,
        originalExercises: List.from(state.exercises),
        hasUnsavedChanges: false,
      ),
    );
  }

  void _onExitEditMode(ExitEditMode event, Emitter<WorkoutState> emit) {
    emit(
      state.copyWith(
        isEditMode: false,
        originalExercises: null,
        hasUnsavedChanges: false,
      ),
    );
  }

  void _onReorderExercises(ReorderExercises event, Emitter<WorkoutState> emit) {
    if (!state.isEditMode) return;

    final exercises = List<Exercise>.from(state.exercises);
    final exercise = exercises.removeAt(event.oldIndex);
    exercises.insert(event.newIndex, exercise);

    // Update order indices
    final updatedExercises = exercises.asMap().entries.map((entry) {
      return entry.value.copyWith(order: entry.key);
    }).toList();

    emit(state.copyWith(exercises: updatedExercises, hasUnsavedChanges: true));
  }

  void _onRemoveExercise(RemoveExercise event, Emitter<WorkoutState> emit) {
    if (!state.isEditMode || event.exerciseIndex >= state.exercises.length) {
      return;
    }

    final exercises = List<Exercise>.from(state.exercises);
    exercises.removeAt(event.exerciseIndex);

    // Update order indices
    final updatedExercises = exercises.asMap().entries.map((entry) {
      return entry.value.copyWith(order: entry.key);
    }).toList();

    // Adjust selected index if necessary
    int newSelectedIndex = state.selectedExerciseIndex;
    if (newSelectedIndex >= updatedExercises.length) {
      newSelectedIndex = updatedExercises.length - 1;
    }
    if (newSelectedIndex < 0) {
      newSelectedIndex = 0;
    }

    emit(
      state.copyWith(
        exercises: updatedExercises,
        selectedExerciseIndex: newSelectedIndex,
        hasUnsavedChanges: true,
      ),
    );
  }

  Future<void> _onSaveChanges(
    SaveChanges event,
    Emitter<WorkoutState> emit,
  ) async {
    if (!state.canSaveChanges) return;

    try {
      emit(state.copyWith(status: WorkoutStatus.loading));

      await _workoutRepository.updateExerciseOrder(state.exercises);

      emit(
        state.copyWith(
          status: WorkoutStatus.loaded,
          isEditMode: false,
          originalExercises: null,
          hasUnsavedChanges: false,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: WorkoutStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void _onDiscardChanges(DiscardChanges event, Emitter<WorkoutState> emit) {
    if (state.originalExercises != null) {
      emit(
        state.copyWith(
          exercises: List.from(state.originalExercises!),
          isEditMode: false,
          originalExercises: null,
          hasUnsavedChanges: false,
        ),
      );
    }
  }

  Future<void> _onAddExercise(
    AddExercise event,
    Emitter<WorkoutState> emit,
  ) async {
    // if (!state.isEditMode) return;

    try {
      emit(state.copyWith(status: WorkoutStatus.loading));

      final exercises = List<Exercise>.from(state.exercises);
      final newExercise = event.exercise.copyWith(order: exercises.length);

      // Create exercise in repository (persists to JSON)
      await _workoutRepository.createExercise(newExercise);

      exercises.add(newExercise);

      // Find the index of the newly added exercise (should be the last one)
      final newExerciseIndex = exercises.length - 1;

      emit(
        state.copyWith(
          status: WorkoutStatus.loaded,
          exercises: exercises,
          selectedExerciseIndex:
              newExerciseIndex, // Auto-select the newly added exercise
          hasUnsavedChanges: true,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: WorkoutStatus.error, errorMessage: e.toString()),
      );
    }
  }

  int _findCurrentExerciseIndex(List<Exercise> exercises) {
    for (int i = 0; i < exercises.length; i++) {
      if (exercises[i].isInProgress) {
        return i;
      }
    }
    // If no exercise is in progress, find the first not started
    for (int i = 0; i < exercises.length; i++) {
      if (exercises[i].isNotStarted) {
        return i;
      }
    }
    // Default to first exercise
    return 0;
  }
}
