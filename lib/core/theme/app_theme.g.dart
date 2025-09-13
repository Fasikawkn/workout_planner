// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppTheme _$AppThemeFromJson(Map<String, dynamic> json) => AppTheme(
  colors: AppColors.fromJson(json['colors'] as Map<String, dynamic>),
  textStyles: AppTextStyles.fromJson(
    json['textStyles'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AppThemeToJson(AppTheme instance) => <String, dynamic>{
  'colors': instance.colors,
  'textStyles': instance.textStyles,
};

AppColors _$AppColorsFromJson(Map<String, dynamic> json) => AppColors(
  primary: json['primary'] as String,
  onPrimary: json['onPrimary'] as String,
  secondary: json['secondary'] as String,
  onSecondary: json['onSecondary'] as String,
  surface: json['surface'] as String,
  onSurface: json['onSurface'] as String,
  background: json['background'] as String,
  onBackground: json['onBackground'] as String,
  error: json['error'] as String,
  onError: json['onError'] as String,
  accent: json['accent'] as String,
  exerciseSelected: json['exerciseSelected'] as String,
  exerciseCompleted: json['exerciseCompleted'] as String,
  equipmentBadge: json['equipmentBadge'] as String,
  hintColor: json['hintColor'] as String,
  borderColor: json['borderColor'] as String,
);

Map<String, dynamic> _$AppColorsToJson(AppColors instance) => <String, dynamic>{
  'primary': instance.primary,
  'onPrimary': instance.onPrimary,
  'secondary': instance.secondary,
  'onSecondary': instance.onSecondary,
  'surface': instance.surface,
  'onSurface': instance.onSurface,
  'background': instance.background,
  'onBackground': instance.onBackground,
  'error': instance.error,
  'onError': instance.onError,
  'accent': instance.accent,
  'exerciseSelected': instance.exerciseSelected,
  'exerciseCompleted': instance.exerciseCompleted,
  'equipmentBadge': instance.equipmentBadge,
  'hintColor': instance.hintColor,
  'borderColor': instance.borderColor,
};

AppTextStyles _$AppTextStylesFromJson(
  Map<String, dynamic> json,
) => AppTextStyles(
  headlineLarge: AppTextStyle.fromJson(
    json['headlineLarge'] as Map<String, dynamic>,
  ),
  headlineMedium: AppTextStyle.fromJson(
    json['headlineMedium'] as Map<String, dynamic>,
  ),
  headlineSmall: AppTextStyle.fromJson(
    json['headlineSmall'] as Map<String, dynamic>,
  ),
  bodyLarge: AppTextStyle.fromJson(json['bodyLarge'] as Map<String, dynamic>),
  bodyMedium: AppTextStyle.fromJson(json['bodyMedium'] as Map<String, dynamic>),
  bodySmall: AppTextStyle.fromJson(json['bodySmall'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppTextStylesToJson(AppTextStyles instance) =>
    <String, dynamic>{
      'headlineLarge': instance.headlineLarge,
      'headlineMedium': instance.headlineMedium,
      'headlineSmall': instance.headlineSmall,
      'bodyLarge': instance.bodyLarge,
      'bodyMedium': instance.bodyMedium,
      'bodySmall': instance.bodySmall,
    };

AppTextStyle _$AppTextStyleFromJson(Map<String, dynamic> json) => AppTextStyle(
  fontSize: (json['fontSize'] as num).toDouble(),
  fontWeight: (json['fontWeight'] as num).toInt(),
  color: json['color'] as String,
);

Map<String, dynamic> _$AppTextStyleToJson(AppTextStyle instance) =>
    <String, dynamic>{
      'fontSize': instance.fontSize,
      'fontWeight': instance.fontWeight,
      'color': instance.color,
    };
