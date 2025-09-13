import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/workout_bloc.dart';
import '../bloc/workout_state.dart';
import '../bloc/workout_event.dart';
import '../widgets/horizontal_exercise_list.dart';
import '../widgets/exercise_details_panel.dart';
import '../widgets/edit_mode_controls.dart';
import '../../../core/utils/constants.dart';

class WorkoutPlannerScreen extends StatelessWidget {
  const WorkoutPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state.status == WorkoutStatus.initial ||
              state.status == WorkoutStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == WorkoutStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: AppConstants.spacingL),
                  Text(
                    'Error loading workout',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppConstants.spacingS),
                  Text(
                    state.errorMessage ?? 'Unknown error occurred',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.spacingXXL),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WorkoutBloc>().add(const LoadWorkout());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              // Main content
              Column(
                children: [
                  // App bar section
                  Container(
                    color: theme.scaffoldBackgroundColor,
                    child: SafeArea(
                      bottom: false,
                      child: _buildAppBar(context, state),
                    ),
                  ),

                  // Exercise list
                  HorizontalExerciseList(
                    exercises: state.exercises,
                    selectedIndex: state.selectedExerciseIndex,
                    isEditMode: state.isEditMode,
                    onExerciseSelected: (index) {
                      context.read<WorkoutBloc>().add(SelectExercise(index));
                    },
                    onEnterEditMode: () {
                      context.read<WorkoutBloc>().add(const EnterEditMode());
                    },
                    onReorder: (oldIndex, newIndex) {
                      context.read<WorkoutBloc>().add(
                        ReorderExercises(oldIndex, newIndex),
                      );
                    },
                    onRemoveExercise: (index) {
                      context.read<WorkoutBloc>().add(RemoveExercise(index));
                    },
                    onLongPress: () {
                      context.read<WorkoutBloc>().add(const EnterEditMode());
                    },
                  ),
                  const SizedBox(height: AppConstants.spacingS),

                  // Exercise details panel
                  Expanded(
                    child: state.selectedExercise != null
                        ? SingleChildScrollView(
                            child: ExerciseDetailsPanel(
                              exercise: state.selectedExercise!,
                              isSelected: true,
                            ),
                          )
                        : const Center(child: Text('No exercise selected')),
                  ),
                ],
              ),

              // Edit mode controls overlay
              if (state.isEditMode)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: EditModeControls(
                    canSaveChanges: state.canSaveChanges,
                    onSaveChanges: () {
                      context.read<WorkoutBloc>().add(const SaveChanges());
                    },
                    onDiscardChanges: () {
                      context.read<WorkoutBloc>().add(const DiscardChanges());
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, WorkoutState state) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.spacingL,
        AppConstants.spacingL,
        AppConstants.spacingL,
        AppConstants.spacingS,
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.onSurface,
            ),
          ),

          // Workout name
          Expanded(
            child: Text(
              state.workout?.workoutName ?? 'Workout',
              style: theme.textTheme.headlineSmall,
            ),
          ),

          // Timer (placeholder)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingM,
              vertical: AppConstants.spacingXS + AppConstants.spacingXXS,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, size: 16),
                SizedBox(width: AppConstants.spacingS),
                Text(
                  '00:28:30',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: AppConstants.spacingM),
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: theme.hintColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: EdgeInsets.all(6),
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
