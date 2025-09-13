import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';
import '../../../core/widgets/app_button.dart';

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
            child: AppButton.elevated(
              radius: 40,
              text: 'Discard',
              onPressed: onDiscardChanges,
              backgroundColor: theme.scaffoldBackgroundColor,
            ),
          ),

          const SizedBox(width: AppConstants.spacingL),

          // Save Changes button
          Expanded(
            child: AppButton.elevated(
              radius: 40,
              text: 'Save Changes',
              onPressed: canSaveChanges ? onSaveChanges : null,
            ),
          ),
        ],
      ),
    );
  }
}
