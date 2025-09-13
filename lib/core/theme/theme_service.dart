import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'app_theme.dart';

@injectable
class ThemeService {
  AppTheme? _lightTheme;
  AppTheme? _darkTheme;

  Future<void> loadThemes() async {
    try {
      final lightThemeJson = await rootBundle.loadString(
        'assets/themes/light.json',
      );
      final darkThemeJson = await rootBundle.loadString(
        'assets/themes/dark.json',
      );

      _lightTheme = AppTheme.fromJson(json.decode(lightThemeJson));
      _darkTheme = AppTheme.fromJson(json.decode(darkThemeJson));
    } catch (e) {
      // Fallback to default themes if loading fails
      _lightTheme = _getDefaultLightTheme();
      _darkTheme = _getDefaultDarkTheme();
    }
  }

  AppTheme get lightTheme => _lightTheme ?? _getDefaultLightTheme();
  AppTheme get darkTheme => _darkTheme ?? _getDefaultDarkTheme();

  AppTheme _getDefaultLightTheme() {
    return const AppTheme(
      colors: AppColors(
        primary: '#007AFF',
        onPrimary: '#FFFFFF',
        secondary: '#FF9500',
        onSecondary: '#FFFFFF',
        surface: '#FFFFFF',
        onSurface: '#000000',
        background: '#F2F2F7',
        onBackground: '#000000',
        error: '#FF3B30',
        onError: '#FFFFFF',
        accent: '#FFD60A',
        exerciseSelected: '#FFD60A',
        exerciseCompleted: '#30D158',
        equipmentBadge: '#8E8E93',
        hintColor: '#000000',
        borderColor: '#000000',
      ),
      textStyles: AppTextStyles(
        headlineLarge: AppTextStyle(
          fontSize: 24.0,
          fontWeight: 6,
          color: '#000000',
        ),
        headlineMedium: AppTextStyle(
          fontSize: 20.0,
          fontWeight: 6,
          color: '#000000',
        ),
        headlineSmall: AppTextStyle(
          fontSize: 18.0,
          fontWeight: 6,
          color: '#000000',
        ),
        bodyLarge: AppTextStyle(
          fontSize: 16.0,
          fontWeight: 4,
          color: '#000000',
        ),
        bodyMedium: AppTextStyle(
          fontSize: 14.0,
          fontWeight: 4,
          color: '#8E8E93',
        ),
        bodySmall: AppTextStyle(
          fontSize: 12.0,
          fontWeight: 4,
          color: '#8E8E93',
        ),
      ),
    );
  }

  AppTheme _getDefaultDarkTheme() {
    return const AppTheme(
      colors: AppColors(
        primary: '#007AFF',
        onPrimary: '#FFFFFF',
        secondary: '#FF9500',
        onSecondary: '#FFFFFF',
        surface: '#1C1C1E',
        onSurface: '#FFFFFF',
        background: '#000000',
        onBackground: '#FFFFFF',
        error: '#FF453A',
        onError: '#000000',
        accent: '#FFD60A',
        exerciseSelected: '#FFD60A',
        exerciseCompleted: '#30D158',
        equipmentBadge: '#8E8E93',
        hintColor: '#FFEEF3',
        borderColor: '#FFE74C',
      ),
      textStyles: AppTextStyles(
        headlineLarge: AppTextStyle(
          fontSize: 24.0,
          fontWeight: 6,
          color: '#FFFFFF',
        ),
        headlineMedium: AppTextStyle(
          fontSize: 20.0,
          fontWeight: 6,
          color: '#FFFFFF',
        ),
        headlineSmall: AppTextStyle(
          fontSize: 18.0,
          fontWeight: 6,
          color: '#FFFFFF',
        ),
        bodyLarge: AppTextStyle(
          fontSize: 16.0,
          fontWeight: 4,
          color: '#FFFFFF',
        ),
        bodyMedium: AppTextStyle(
          fontSize: 14.0,
          fontWeight: 4,
          color: '#8E8E93',
        ),
        bodySmall: AppTextStyle(
          fontSize: 12.0,
          fontWeight: 4,
          color: '#8E8E93',
        ),
      ),
    );
  }
}
