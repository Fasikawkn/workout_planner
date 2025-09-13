import 'package:flutter/material.dart';
import '../models/exercise.dart';
import 'exercise_image_display.dart';
import 'exercise_action_button.dart';
import '../../../core/utils/constants.dart';

class ExerciseDetailsPanel extends StatelessWidget {
  final Exercise exercise;
  final bool isSelected;

  const ExerciseDetailsPanel({
    super.key,
    required this.exercise,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingXL),
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingL),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise name and replace button row
          Row(
            children: [
              Expanded(
                child: Text(
                  exercise.name,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),

              SizedBox(
                child: TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: theme.colorScheme.surfaceContainer,
                    foregroundColor: theme.colorScheme.onSurface,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingL,
                      vertical: AppConstants.spacingS,
                    ),
                  ),
                  icon: const Icon(Icons.swap_horiz, size: 18),
                  label: Text(
                    'Replace',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingL),

          // Exercise image/GIF
          ExerciseImageDisplay(exercise: exercise, isSelected: isSelected),

          const SizedBox(height: AppConstants.spacingL),

          // Action buttons
          Row(
            children: [
              ExerciseActionButton(
                flex: 4,
                icon: 'assets/icons/instructions.png',
                label: 'Instructions',
                onPressed: () {},
              ),

              const SizedBox(width: AppConstants.spacingS),

              ExerciseActionButton(
                flex: 3,
                icon: 'assets/icons/warmup.png',
                label: 'Warm Up',
                onPressed: () {},
              ),

              const SizedBox(width: AppConstants.spacingS),

              ExerciseActionButton(
                flex: 2,
                icon: 'assets/icons/faq.png',
                label: 'FAQ',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
