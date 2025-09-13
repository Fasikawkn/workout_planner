import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';

class ExerciseActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback? onPressed;
  final int flex;

  const ExerciseActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      flex: flex,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingM,
          ),
          side: BorderSide(color: theme.colorScheme.onSurface),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        icon: Image.asset(
          width: 16,
          height: 16,
          icon,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.fitness_center,
              size: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            );
          },
        ),
        label: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
