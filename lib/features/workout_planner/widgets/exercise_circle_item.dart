import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../../../core/utils/constants.dart';

class ExerciseCircleItem extends StatelessWidget {
  final Exercise exercise;
  final bool isSelected;
  final bool isEditMode;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onRemove;

  const ExerciseCircleItem({
    super.key,
    required this.exercise,
    required this.isSelected,
    required this.isEditMode,
    required this.onTap,
    this.onLongPress,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 72,
        height: 72,
        margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingS),
        child: Stack(
          children: [
            // Main circle container
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.surfaceContainer
                      : theme.colorScheme.onPrimary,
                  width: 3,
                ),
                color: theme.colorScheme.surface,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.surface,
                  border: Border.all(
                    color: theme.scaffoldBackgroundColor,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    exercise.assetUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: theme.colorScheme.surface,
                        child: Icon(
                          Icons.fitness_center,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Status overlay
            if (exercise.isCompleted || exercise.isInProgress || isSelected)
              Positioned(
                right: 0,
                bottom: 6,
                child: Center(child: _buildStatusIcon(context)),
              ),

            // Remove button in edit mode
            if (isEditMode && onRemove != null)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.error,
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 20,
                      weight: 100,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(BuildContext context) {
    final theme = Theme.of(context);
    if (isSelected) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.surfaceContainer,
          border: Border.all(color: theme.colorScheme.onPrimary, width: 2),
        ),
        child: Icon(
          Icons.play_arrow,
          color: theme.colorScheme.onSurface,
          size: 12,
        ),
      );
    } else if (exercise.isCompleted) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.surfaceContainer,
          border: Border.all(color: theme.colorScheme.onPrimary, width: 2),
        ),
        child: Icon(
          Icons.check,
          color: theme.colorScheme.onSurface,
          size: 12,
          weight: 10,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
