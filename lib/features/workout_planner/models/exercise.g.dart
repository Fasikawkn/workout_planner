// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
  name: json['name'] as String,
  assetUrl: json['asset_url'] as String,
  gifAssetUrl: json['gif_asset_url'] as String,
  equipment: json['equipment'] as String,
  status: json['status'] as String? ?? 'not_started',
  order: (json['order'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
  'name': instance.name,
  'asset_url': instance.assetUrl,
  'gif_asset_url': instance.gifAssetUrl,
  'equipment': instance.equipment,
  'status': instance.status,
  'order': instance.order,
};
