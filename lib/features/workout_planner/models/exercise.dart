import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'exercise.g.dart';

@JsonSerializable()
class Exercise extends Equatable {
  final String name;
  @JsonKey(name: 'asset_url')
  final String assetUrl;
  @JsonKey(name: 'gif_asset_url')
  final String gifAssetUrl;
  final String equipment;

  // Local state properties
  final String status; // 'not_started', 'in_progress', 'completed'
  final int order;

  const Exercise({
    required this.name,
    required this.assetUrl,
    required this.gifAssetUrl,
    required this.equipment,
    this.status = 'not_started',
    this.order = 0,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  Exercise copyWith({
    String? name,
    String? assetUrl,
    String? gifAssetUrl,
    String? equipment,
    String? status,
    int? order,
  }) {
    return Exercise(
      name: name ?? this.name,
      assetUrl: assetUrl ?? this.assetUrl,
      gifAssetUrl: gifAssetUrl ?? this.gifAssetUrl,
      equipment: equipment ?? this.equipment,
      status: status ?? this.status,
      order: order ?? this.order,
    );
  }

  bool get isCompleted => status == 'completed';
  bool get isInProgress => status == 'in_progress';
  bool get isNotStarted => status == 'not_started';

  @override
  List<Object?> get props => [
    name,
    assetUrl,
    gifAssetUrl,
    equipment,
    status,
    order,
  ];
}
