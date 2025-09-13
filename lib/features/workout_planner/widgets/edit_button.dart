import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onTap;

  const EditButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: theme.colorScheme.onPrimary, width: 3),
          color: theme.colorScheme.surface,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.surface,
            border: Border.all(color: theme.scaffoldBackgroundColor, width: 3),
          ),

          child: Icon(
            Icons.edit_outlined,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            size: 24,
          ),
        ),
      ),
    );
  }
}
