class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'http://localhost:3000';
  static const String workoutEndpoint = '/workouts';
  static const String exercisesEndpoint = '/workouts/exercises';

  // Equipment types
  static const String equipmentBarbell = 'barbell';
  static const String equipmentDumbbell = 'dumbbell';
  static const String equipmentCable = 'cable';
  static const String equipmentBodyweight = 'bodyweight';
  static const String equipmentMachine = 'machine';

  // Local storage keys
  static const String workoutDataKey = 'workout_data';
  static const String themeKey = 'theme_preference';

  // Exercise states
  static const String exerciseStateNotStarted = 'not_started';
  static const String exerciseStateInProgress = 'in_progress';
  static const String exerciseStateCompleted = 'completed';

  // Equipment icons mapping
  static const Map<String, String> equipmentIcons = {
    equipmentBarbell: 'assets/icons/barbell.png',
    equipmentDumbbell: 'assets/icons/dumbbell.png',
    equipmentCable: 'assets/icons/cable.png',
    equipmentBodyweight: 'assets/icons/bodyweight.png',
    equipmentMachine: 'assets/icons/machine.png',
  };

  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Spacing constants for consistent padding and margins
  static const double spacingXXS = 2.0;
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 12.0;
  static const double spacingL = 16.0;
  static const double spacingXL = 20.0;
  static const double spacingXXL = 24.0;
}
