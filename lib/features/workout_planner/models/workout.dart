import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'exercise.dart';

part 'workout.g.dart';

@JsonSerializable()
class Workout extends Equatable {
  @JsonKey(name: 'workout_name')
  final String workoutName;
  final List<Exercise> exercises;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Workout({
    required this.workoutName,
    required this.exercises,
    this.createdAt,
    this.updatedAt,
  });

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);

  Workout copyWith({
    String? workoutName,
    List<Exercise>? exercises,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Workout(
      workoutName: workoutName ?? this.workoutName,
      exercises: exercises ?? this.exercises,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper methods
  int get totalExercises => exercises.length;
  int get completedExercises => exercises.where((e) => e.isCompleted).length;
  int get remainingExercises => totalExercises - completedExercises;
  double get progressPercentage =>
      totalExercises > 0 ? completedExercises / totalExercises : 0.0;

  Exercise? get currentExercise =>
      exercises.where((e) => e.isInProgress).firstOrNull;

  Exercise? get nextExercise =>
      exercises.where((e) => e.isNotStarted).firstOrNull;

  @override
  List<Object?> get props => [workoutName, exercises, createdAt, updatedAt];
}

extension ListExtension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
