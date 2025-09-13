import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';

class EditModeControls extends StatelessWidget {
  final bool canSaveChanges;
  final VoidCallback onSaveChanges;
  final VoidCallback onDiscardChanges;

  const EditModeControls({
    super.key,
    required this.canSaveChanges,
    required this.onSaveChanges,
    required this.onDiscardChanges,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingS),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Discard button
          Expanded(
            child: ElevatedButton(
              onPressed: onDiscardChanges,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.spacingL,
                ),
                backgroundColor: theme.scaffoldBackgroundColor,
                elevation: 0,
              ),
              child: Text(
                'Discard',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(width: AppConstants.spacingL),

          // Save Changes button
          Expanded(
            child: ElevatedButton(
              onPressed: canSaveChanges ? onSaveChanges : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.spacingL,
                ),
                backgroundColor: theme.colorScheme.surfaceContainer,
                foregroundColor: Colors.black,
                disabledBackgroundColor: theme.colorScheme.surfaceContainer
                    .withValues(alpha: 0.5),
                elevation: 0,
              ),
              child: Text(
                'Save Changes',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
