import 'package:flutter/material.dart';
import '../models/exercise.dart';
import 'exercise_circle_item.dart';
import 'edit_button.dart';
import 'create_button.dart';
import 'create_exercise_bottom_sheet.dart';
import '../../../core/utils/constants.dart';

class HorizontalExerciseList extends StatefulWidget {
  final List<Exercise> exercises;
  final int selectedIndex;
  final bool isEditMode;
  final Function(int) onExerciseSelected;
  final VoidCallback onEnterEditMode;
  final Function(int, int) onReorder;
  final Function(int) onRemoveExercise;
  final Function(Exercise) onExerciseCreated;
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
    required this.onExerciseCreated,
    this.onLongPress,
  });

  @override
  State<HorizontalExerciseList> createState() => _HorizontalExerciseListState();
}

class _HorizontalExerciseListState extends State<HorizontalExerciseList> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.spacingS + AppConstants.spacingXXS,
      ),
      child: widget.isEditMode ? _buildEditModeList() : _buildNormalList(),
    );
  }

  void _showCreateExerciseBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          CreateExerciseBottomSheet(onExerciseCreated: widget.onExerciseCreated),
    );
  }

  Widget _buildNormalList() {
    return ListView.builder(
      key: const PageStorageKey('exercise_list'),
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingL),
      itemCount: widget.exercises.length + 2, // +2 for edit and create buttons
      itemBuilder: (context, index) {
        if (index == widget.exercises.length) {
          // Create button
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 16.0),
            child: CreateButton(
              onTap: () => _showCreateExerciseBottomSheet(context),
            ),
          );
        } else if (index == widget.exercises.length + 1) {
          // Edit button at the end
          return EditButton(onTap: widget.onEnterEditMode);
        }

        final exercise = widget.exercises[index];
        return ExerciseCircleItem(
          exercise: exercise,
          isSelected: index == widget.selectedIndex,
          isEditMode: false,
          onTap: () => widget.onExerciseSelected(index),
          onLongPress: widget.onLongPress,
        );
      },
    );
  }

  Widget _buildEditModeList() {
    return ReorderableListView.builder(
      key: const PageStorageKey('exercise_list'),
      scrollController: scrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingL),
      itemCount: widget.exercises.length,
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        widget.onReorder(oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        final exercise = widget.exercises[index];
        return SizedBox(
          key: ValueKey('${exercise.name}_$index'),
          width: 96,
          child: ExerciseCircleItem(
            exercise: exercise,
            isSelected: false,
            isEditMode: true,
            onTap: () {}, // Disabled in edit mode
            onRemove: () => widget.onRemoveExercise(index),
          ),
        );
      },
    );
  }
}
