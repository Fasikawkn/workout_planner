import 'package:flutter/material.dart';
import '../../../core/widgets/app_button.dart';

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
    return SizedBox(
      height: 32,
      child: AppButton.outlined(
        radius: 40,
        text: label,
        onPressed: onPressed,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        icon: Image.asset(
          width: 16,
          height: 16,
          icon,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.fitness_center,
              size: 16,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            );
          },
        ),
      ),
    );
  }
}
