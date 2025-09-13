import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/theme/theme_service.dart';
import 'features/workout_planner/bloc/workout_bloc.dart';
import 'features/workout_planner/bloc/workout_event.dart';
import 'features/workout_planner/screens/workout_planner_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure dependency injection
  await configureDependencies();

  // Load themes
  final themeService = getIt<ThemeService>();
  await themeService.loadThemes();

  runApp(WorkoutPlannerApp(themeService: themeService));
}

class WorkoutPlannerApp extends StatefulWidget {
  final ThemeService themeService;

  const WorkoutPlannerApp({super.key, required this.themeService});

  @override
  State<WorkoutPlannerApp> createState() => _WorkoutPlannerAppState();
}

class _WorkoutPlannerAppState extends State<WorkoutPlannerApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Planner',
      theme: widget.themeService.lightTheme.toThemeData(),
      darkTheme: widget.themeService.darkTheme.toThemeData(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => getIt<WorkoutBloc>()..add(const LoadWorkout()),
        child: const WorkoutPlannerScreen(),
      ),
    );
  }
}
