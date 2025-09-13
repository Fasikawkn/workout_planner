// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:workout_planner/main.dart';
import 'package:workout_planner/core/theme/theme_service.dart';

void main() {
  testWidgets('App loads properly', (WidgetTester tester) async {
    // Create a mock theme service
    final themeService = ThemeService();
    await themeService.loadThemes();

    // Build our app and trigger a frame.
    await tester.pumpWidget(WorkoutPlannerApp(themeService: themeService));

    // Verify that our app loads without error
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
