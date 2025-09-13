import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;

  const CircleButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.size = 72,
    this.iconSize = 24,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? theme.colorScheme.onPrimary,
            width: 3,
          ),
          color: backgroundColor ?? theme.colorScheme.surface,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? theme.colorScheme.surface,
            border: Border.all(color: theme.scaffoldBackgroundColor, width: 3),
          ),
          child: Icon(
            icon,
            color:
                iconColor ?? theme.colorScheme.onSurface.withValues(alpha: 0.7),
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
