import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double radius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isOutlined = false,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.radius = 12,
  });

  // Factory constructor for elevated button (default)
  const AppButton.elevated({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.radius = 12,
  }) : isOutlined = false;

  // Factory constructor for outlined button
  const AppButton.outlined({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.radius = 12,
  }) : isOutlined = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttonChild = _buildButtonChild(theme);

    Widget button;

    if (isOutlined) {
      button = icon != null
          ? OutlinedButton.icon(
              onPressed: isLoading ? null : onPressed,
              style: _getOutlinedButtonStyle(theme),
              icon: icon!,
              label: buttonChild,
            )
          : OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: _getOutlinedButtonStyle(theme),
              child: buttonChild,
            );
    } else {
      button = icon != null
          ? ElevatedButton.icon(
              onPressed: isLoading ? null : onPressed,
              style: _getElevatedButtonStyle(theme),
              icon: icon!,
              label: buttonChild,
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: _getElevatedButtonStyle(theme),
              child: buttonChild,
            );
    }

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Widget _buildButtonChild(ThemeData theme) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            foregroundColor ?? theme.colorScheme.onSurface,
          ),
        ),
      );
    }

    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: foregroundColor ?? theme.colorScheme.onSurface,
      ),
    );
  }

  ButtonStyle _getElevatedButtonStyle(ThemeData theme) {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingL,
        vertical: AppConstants.spacingM,
      ),
      backgroundColor: backgroundColor ?? theme.colorScheme.surfaceContainer,
      foregroundColor: foregroundColor ?? theme.colorScheme.onSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      disabledBackgroundColor:
          (backgroundColor ?? theme.colorScheme.surfaceContainer).withValues(
            alpha: 0.5,
          ),
    );
  }

  ButtonStyle _getOutlinedButtonStyle(ThemeData theme) {
    return OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingL,
        vertical: 0,
      ),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor ?? theme.colorScheme.onSurface,
      side: BorderSide(color: theme.colorScheme.onSurface),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
