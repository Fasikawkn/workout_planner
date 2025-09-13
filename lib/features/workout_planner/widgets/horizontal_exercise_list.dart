import 'package:flutter/material.dart';
import '../models/exercise.dart';
import 'exercise_circle_item.dart';
import 'edit_button.dart';
import '../../../core/utils/constants.dart';

class HorizontalExerciseList extends StatelessWidget {
  final List<Exercise> exercises;
  final int selectedIndex;
  final bool isEditMode;
  final Function(int) onExerciseSelected;
  final VoidCallback onEnterEditMode;
  final Function(int, int) onReorder;
  final Function(int) onRemoveExercise;
  final VoidCallback? onLongPress;

  const HorizontalExerciseList({
    super.key,
    required this.exercises,
    required this.selectedIndex,
    required this.isEditMode,
    required this.onExerciseSelected,
    required this.onEnterEditMode,
    required this.onReorder,
    required this.onRemoveExercise,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.spacingS + AppConstants.spacingXXS,
      ),
      child: isEditMode ? _buildEditModeList() : _buildNormalList(),
    );
  }

  Widget _buildNormalList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingL),
      itemCount: exercises.length + 1, // +1 for edit button
      itemBuilder: (context, index) {
        if (index == exercises.length) {
          // Edit button at the end
          return EditButton(onTap: onEnterEditMode);
        }

        final exercise = exercises[index];
        return ExerciseCircleItem(
          exercise: exercise,
          isSelected: index == selectedIndex,
          isEditMode: false,
          onTap: () => onExerciseSelected(index),
          onLongPress: onLongPress,
        );
      },
    );
  }

  Widget _buildEditModeList() {
    return ReorderableListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingL),
      itemCount: exercises.length,
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        onReorder(oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        final exercise = exercises[index];
        return SizedBox(
          key: ValueKey('${exercise.name}_$index'),
          width: 96,
          child: ExerciseCircleItem(
            exercise: exercise,
            isSelected: false,
            isEditMode: true,
            onTap: () {}, // Disabled in edit mode
            onRemove: () => onRemoveExercise(index),
          ),
        );
      },
    );
  }
}
