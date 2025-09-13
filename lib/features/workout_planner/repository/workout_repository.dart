import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/exceptions.dart';
import '../../../core/utils/api_client.dart';
import '../../../core/utils/constants.dart';
import '../models/exercise.dart';
import '../models/workout.dart';

abstract class WorkoutRepository {
  Future<Workout> getWorkout();
  Future<void> saveWorkout(Workout workout);
  Future<List<Exercise>> getExercises();
  Future<Exercise> createExercise(Exercise exercise);
  Future<void> updateExerciseOrder(List<Exercise> exercises);
  Future<void> updateExerciseStatus(String exerciseName, String status);
}

@Injectable(as: WorkoutRepository)
class WorkoutRepositoryImpl implements WorkoutRepository {
  final SharedPreferences _prefs;
  final ApiClient _apiClient;

  WorkoutRepositoryImpl(this._prefs, this._apiClient);

  @override
  Future<Workout> getWorkout() async {
    try {
      // First try to load from local storage (user modifications)
      final savedWorkoutJson = _prefs.getString(AppConstants.workoutDataKey);

      if (savedWorkoutJson != null) {
        final workoutData = json.decode(savedWorkoutJson);
        return Workout.fromJson(workoutData);
      }

      // If no saved workout, load from API
      return await _loadWorkoutFromApi();
    } catch (e) {
      // Fallback to assets if API fails
      try {
        return await _loadWorkoutFromAssets();
      } catch (assetError) {
        throw CacheException(
          message:
              'Failed to load workout from both API and assets: $e, $assetError',
          data: e,
        );
      }
    }
  }

  @override
  Future<void> saveWorkout(Workout workout) async {
    try {
      final workoutJson = json.encode(workout.toJson());
      await _prefs.setString(AppConstants.workoutDataKey, workoutJson);
    } catch (e) {
      throw CacheException(message: 'Failed to save workout: $e', data: e);
    }
  }

  @override
  Future<List<Exercise>> getExercises() async {
    try {
      final workout = await getWorkout();
      return workout.exercises;
    } catch (e) {
      throw CacheException(message: 'Failed to load exercises: $e', data: e);
    }
  }

  @override
  Future<void> updateExerciseOrder(List<Exercise> exercises) async {
    try {
      final workout = await getWorkout();
      final updatedExercises = exercises.asMap().entries.map((entry) {
        return entry.value.copyWith(order: entry.key);
      }).toList();

      final updatedWorkout = workout.copyWith(
        exercises: updatedExercises,
        updatedAt: DateTime.now(),
      );

      await saveWorkout(updatedWorkout);
    } catch (e) {
      throw CacheException(
        message: 'Failed to update exercise order: $e',
        data: e,
      );
    }
  }

  @override
  Future<void> updateExerciseStatus(String exerciseName, String status) async {
    try {
      final workout = await getWorkout();
      final updatedExercises = workout.exercises.map((exercise) {
        if (exercise.name == exerciseName) {
          return exercise.copyWith(status: status);
        }
        return exercise;
      }).toList();

      final updatedWorkout = workout.copyWith(
        exercises: updatedExercises,
        updatedAt: DateTime.now(),
      );

      await saveWorkout(updatedWorkout);
    } catch (e) {
      throw CacheException(
        message: 'Failed to update exercise status: $e',
        data: e,
      );
    }
  }

  @override
  Future<Exercise> createExercise(Exercise exercise) async {
    try {
      // Since exercises are nested under workouts, we need to:
      // 1. Get the current workout
      // 2. Add the new exercise to the exercises array
      // 3. Update the entire workout

      final currentWorkout = await _loadWorkoutFromApi();
      final updatedExercises = [...currentWorkout.exercises, exercise];

      final updatedWorkout = currentWorkout.copyWith(
        exercises: updatedExercises,
        updatedAt: DateTime.now(),
      );

      // Update the entire workout with the new exercise
      await _apiClient.put(
        '${AppConstants.apiBaseUrl}${AppConstants.workoutEndpoint}',
        body: {
          'workout_name': updatedWorkout.workoutName,
          'exercises': updatedExercises.map((e) => e.toJson()).toList(),
        },
      );

      // Save updated workout to local storage
      await saveWorkout(updatedWorkout);

      return exercise;
    } catch (e) {
      throw NetworkException(message: 'Failed to create exercise: $e', data: e);
    }
  }

  Future<Workout> _loadWorkoutFromApi() async {
    try {
      // Fetch the complete workout data from /workouts endpoint
      final response = await _apiClient.get(
        '${AppConstants.apiBaseUrl}${AppConstants.workoutEndpoint}',
      );

      final workout = Workout.fromJson(response);

      // Save to local storage for future use
      await saveWorkout(workout);

      return workout;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to load workout from API: $e',
        data: e,
      );
    }
  }

  Future<Workout> _loadWorkoutFromAssets() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/sample_workout.json',
      );
      final workoutData = json.decode(jsonString);
      final workout = Workout.fromJson(workoutData);

      // Save to local storage for future use
      await saveWorkout(workout);

      return workout;
    } catch (e) {
      throw ParseException(
        message: 'Failed to load workout from assets: $e',
        data: e,
      );
    }
  }
}
