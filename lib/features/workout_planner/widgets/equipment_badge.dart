import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';

class EquipmentBadge extends StatelessWidget {
  final String equipment;

  const EquipmentBadge({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingM,
        vertical: AppConstants.spacingXS + AppConstants.spacingXXS,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Equipment icon
          Image.asset(
            AppConstants.equipmentIcons[equipment.toLowerCase()] ??
                AppConstants.equipmentIcons[AppConstants.equipmentDumbbell]!,
            width: 16,
            height: 16,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.fitness_center,
                size: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              );
            },
          ),

          const SizedBox(
            width: AppConstants.spacingXS + AppConstants.spacingXXS,
          ),

          // Equipment name
          Text(
            _formatEquipmentName(equipment),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatEquipmentName(String equipment) {
    switch (equipment.toLowerCase()) {
      case 'barbell':
        return 'Barbell';
      case 'dumbbell':
        return 'Dumbbell';
      case 'cable':
        return 'Cable';
      case 'bodyweight':
        return 'Bodyweight';
      case 'machine':
        return 'Machine';
      default:
        return equipment.toUpperCase();
    }
  }
}
