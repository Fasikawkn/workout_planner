import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_theme.g.dart';

@JsonSerializable()
class AppTheme {
  final AppColors colors;
  final AppTextStyles textStyles;

  const AppTheme({required this.colors, required this.textStyles});

  factory AppTheme.fromJson(Map<String, dynamic> json) =>
      _$AppThemeFromJson(json);

  Map<String, dynamic> toJson() => _$AppThemeToJson(this);

  ThemeData toThemeData() {
    return ThemeData(
      primaryColor: Color(int.parse(colors.primary.replaceFirst('#', '0xFF'))),
      scaffoldBackgroundColor: Color(
        int.parse(colors.background.replaceFirst('#', '0xFF')),
      ),
      fontFamily: GoogleFonts.manrope().fontFamily,
      hintColor: Color(int.parse(colors.hintColor.replaceFirst('#', '0xFF'))),
      dividerColor: Color(int.parse(colors.equipmentBadge.replaceFirst('#', '0xFF'))),
      colorScheme: ColorScheme(
        brightness: colors.background == '#FFFFFF'
            ? Brightness.light
            : Brightness.dark,
        primary: Color(int.parse(colors.primary.replaceFirst('#', '0xFF'))),
        onPrimary: Color(int.parse(colors.onPrimary.replaceFirst('#', '0xFF'))),
        secondary: Color(int.parse(colors.secondary.replaceFirst('#', '0xFF'))),
        onSecondary: Color(
          int.parse(colors.onSecondary.replaceFirst('#', '0xFF')),
        ),
        surface: Color(int.parse(colors.surface.replaceFirst('#', '0xFF'))),
        onSurface: Color(int.parse(colors.onSurface.replaceFirst('#', '0xFF'))),
        error: Color(int.parse(colors.error.replaceFirst('#', '0xFF'))),
        onError: Color(int.parse(colors.onError.replaceFirst('#', '0xFF'))),
        surfaceContainer: Color(int.parse(colors.borderColor.replaceFirst('#', '0xFF'))),
        
      ),
      textTheme: GoogleFonts.manropeTextTheme().copyWith(
        headlineLarge: GoogleFonts.manrope(
          fontSize: textStyles.headlineLarge.fontSize,
          fontWeight: FontWeight.values[textStyles.headlineLarge.fontWeight],
          color: Color(
            int.parse(textStyles.headlineLarge.color.replaceFirst('#', '0xFF')),
          ),
        ),
        headlineMedium: GoogleFonts.manrope(
          fontSize: textStyles.headlineMedium.fontSize,
          fontWeight: FontWeight.values[textStyles.headlineMedium.fontWeight],
          color: Color(
            int.parse(
              textStyles.headlineMedium.color.replaceFirst('#', '0xFF'),
            ),
          ),
        ),
        headlineSmall: GoogleFonts.manrope(
          fontSize: textStyles.headlineSmall.fontSize,
          fontWeight: FontWeight.values[textStyles.headlineSmall.fontWeight],
          color: Color(
            int.parse(textStyles.headlineSmall.color.replaceFirst('#', '0xFF')),
          ),
        ),
        bodyLarge: GoogleFonts.manrope(
          fontSize: textStyles.bodyLarge.fontSize,
          fontWeight: FontWeight.values[textStyles.bodyLarge.fontWeight],
          color: Color(
            int.parse(textStyles.bodyLarge.color.replaceFirst('#', '0xFF')),
          ),
        ),
        bodyMedium: GoogleFonts.manrope(
          fontSize: textStyles.bodyMedium.fontSize,
          fontWeight: FontWeight.values[textStyles.bodyMedium.fontWeight],
          color: Color(
            int.parse(textStyles.bodyMedium.color.replaceFirst('#', '0xFF')),
          ),
        ),
        bodySmall: GoogleFonts.manrope(
          fontSize: textStyles.bodySmall.fontSize,
          fontWeight: FontWeight.values[textStyles.bodySmall.fontWeight],
          color: Color(
            int.parse(textStyles.bodySmall.color.replaceFirst('#', '0xFF')),
          ),
        ),
      ),
    );
  }
}

@JsonSerializable()
class AppColors {
  final String primary;
  final String onPrimary;
  final String secondary;
  final String onSecondary;
  final String surface;
  final String onSurface;
  final String background;
  final String onBackground;
  final String error;
  final String onError;
  final String accent;
  final String exerciseSelected;
  final String exerciseCompleted;
  final String equipmentBadge;
  final String hintColor;
  final String borderColor;

  const AppColors({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.onSurface,
    required this.background,
    required this.onBackground,
    required this.error,
    required this.onError,
    required this.accent,
    required this.exerciseSelected,
    required this.exerciseCompleted,
    required this.equipmentBadge,
    required this.hintColor,
    required this.borderColor,
  });

  factory AppColors.fromJson(Map<String, dynamic> json) =>
      _$AppColorsFromJson(json);

  Map<String, dynamic> toJson() => _$AppColorsToJson(this);
}

@JsonSerializable()
class AppTextStyles {
  final AppTextStyle headlineLarge;
  final AppTextStyle headlineMedium;
  final AppTextStyle headlineSmall;
  final AppTextStyle bodyLarge;
  final AppTextStyle bodyMedium;
  final AppTextStyle bodySmall;

  const AppTextStyles({
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
  });

  factory AppTextStyles.fromJson(Map<String, dynamic> json) =>
      _$AppTextStylesFromJson(json);

  Map<String, dynamic> toJson() => _$AppTextStylesToJson(this);
}

@JsonSerializable()
class AppTextStyle {
  final double fontSize;
  final int fontWeight;
  final String color;

  const AppTextStyle({
    required this.fontSize,
    required this.fontWeight,
    required this.color,
  });

  factory AppTextStyle.fromJson(Map<String, dynamic> json) =>
      _$AppTextStyleFromJson(json);

  Map<String, dynamic> toJson() => _$AppTextStyleToJson(this);
}
