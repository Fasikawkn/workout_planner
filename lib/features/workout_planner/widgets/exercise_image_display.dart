import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/exercise.dart';
import 'equipment_badge.dart';

class ExerciseImageDisplay extends StatelessWidget {
  final Exercise exercise;
  final bool isSelected;

  const ExerciseImageDisplay({
    super.key,
    required this.exercise,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Exercise image/gif
            CachedNetworkImage(
              imageUrl: isSelected ? exercise.gifAssetUrl : exercise.assetUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: theme.colorScheme.surface,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: theme.colorScheme.surface,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fitness_center,
                      size: 64,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: AppConstants.spacingS),
                    Text(
                      exercise.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            // Equipment badge
            Positioned(
              bottom: 12,
              left: 12,
              child: Row(
                children: [EquipmentBadge(equipment: exercise.equipment)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
