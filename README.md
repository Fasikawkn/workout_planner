# Workout Planner Flutter App

A comprehensive Flutter application that allows users to track and manage their workout routines with advanced features including exercise reordering, real-time status updates, and dynamic theming.

## Features

### Core Features

- ✅ **Horizontal Exercise List**: Scrollable exercise list with circular item design
- ✅ **Exercise Selection**: Tap to select exercises with visual feedback
- ✅ **Status Indicators**: Visual checkmarks for completed exercises and play icons for current exercise
- ✅ **Exercise Details Panel**: Display exercise name, animated GIF, equipment badges, and action buttons
- ✅ **Edit Mode**: Long press or edit button to enter edit mode
- ✅ **Drag & Drop Reordering**: Reorder exercises horizontally in edit mode
- ✅ **Exercise Removal**: Remove exercises with minus button in edit mode
- ✅ **Save/Discard Changes**: Persistent local storage with change management

### Technical Features

- ✅ **Feature-First Architecture**: Clean separation of concerns with feature-based folder structure
- ✅ **BLoC State Management**: Reactive state management using flutter_bloc
- ✅ **Dependency Injection**: get_it + injectable for clean dependency management
- ✅ **JSON Serialization**: Automatic JSON parsing with json_serializable
- ✅ **Dynamic Theming**: JSON-configurable light and dark themes
- ✅ **Exception Handling**: Comprehensive error handling with custom exception classes
- ✅ **Generic API Client**: Flexible HTTP client for dynamic route handling
- ✅ **Local Data Persistence**: SharedPreferences for local storage
- ✅ **Modular Components**: Broken down into smaller, reusable widgets

## Architecture

### Folder Structure

```
lib/
├── core/
│   ├── di/                  # Dependency Injection
│   │   ├── injection.dart
│   │   └── injection.config.dart
│   ├── models/              # Core Models
│   │   └── exceptions.dart
│   ├── theme/               # Theme System
│   │   ├── app_theme.dart
│   │   ├── app_theme.g.dart
│   │   └── theme_service.dart
│   └── utils/               # Utilities
│       ├── api_client.dart
│       └── constants.dart
├── features/
│   └── workout_planner/
│       ├── bloc/            # State Management
│       │   ├── workout_bloc.dart
│       │   ├── workout_event.dart
│       │   └── workout_state.dart
│       ├── models/          # Feature Models
│       │   ├── exercise.dart
│       │   ├── exercise.g.dart
│       │   ├── workout.dart
│       │   └── workout.g.dart
│       ├── repository/      # Data Layer
│       │   └── workout_repository.dart
│       ├── screens/         # UI Screens
│       │   └── workout_planner_screen.dart
│       └── widgets/         # UI Components
│           ├── edit_button.dart
│           ├── edit_mode_controls.dart
│           ├── equipment_badge.dart
│           ├── exercise_action_button.dart
│           ├── exercise_circle_item.dart
│           ├── exercise_details_panel.dart
│           ├── exercise_image_display.dart
│           └── horizontal_exercise_list.dart
└── main.dart
```

### Assets Structure

```
assets/
├── data/
│   └── sample_workout.json   # Sample workout data
├── themes/
│   ├── light.json           # Light theme configuration
│   └── dark.json            # Dark theme configuration
└── icons/
    ├── barbell.png
    ├── dumbbell.png
    ├── cable.png
    ├── bodyweight.png
    └── machine.png
```

## Dependencies

### Production Dependencies

- **flutter_bloc**: State management with BLoC pattern
- **get_it**: Service locator for dependency injection
- **injectable**: Code generation for dependency injection
- **json_annotation**: JSON serialization annotations
- **http**: HTTP client for API calls
- **cached_network_image**: Efficient network image loading with caching
- **shared_preferences**: Local data persistence
- **equatable**: Value equality for Dart objects

### Development Dependencies

- **build_runner**: Code generation runner
- **json_serializable**: JSON serialization code generation
- **injectable_generator**: Dependency injection code generation
- **flutter_lints**: Dart linting rules

## Setup Instructions

### Prerequisites

- Flutter SDK (>=3.8.0)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- VS Code (recommended IDE)

### Installation Steps

1. **Clone the Repository**

   ```bash
   git clone <repository-url>
   cd workout_planner
   ```
2. **Install Dependencies**

   ```bash
   flutter pub get
   ```
3. **Install JSON Server (for API development)**

   ```bash
   npm install -g json-server
   ```
4. **Start JSON Server**

   ```bash
   json-server server/db.json --port 3000
   ```

   The JSON server will provide the following endpoints:

   - `GET http://localhost:3000/workouts` - Get complete workout data
   - `PUT http://localhost:3000/workouts` - Update workout with exercises
   - `POST http://localhost:3000/exercises` - Create new exercise (if supported)
   - `PUT http://localhost:3000/exercises/:id` - Update exercise
   - `DELETE http://localhost:3000/exercises/:id` - Delete exercise
5. **Generate Code**

   ```bash
   flutter packages pub run build_runner build
   ```
6. **Run the Application**

   ```bash
   flutter run
   ```

### Alternative Build Command (if needed)

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Key Components

### 1. BLoC State Management

The app uses BLoC pattern for state management with the following events:

- `LoadWorkout`: Load workout data from storage/assets
- `SelectExercise`: Select an exercise from the list
- `EnterEditMode`/`ExitEditMode`: Toggle edit mode
- `ReorderExercises`: Reorder exercises via drag & drop
- `RemoveExercise`: Remove an exercise from the list
- `SaveChanges`/`DiscardChanges`: Persist or discard changes

### 2. Generic API Client

The app includes a flexible API client that can handle dynamic routes and parameters:

```dart
// GET request with parameters
final data = await apiClient.get('/api/workouts', 
    parameters: {'userId': '123'});

// POST request with body
await apiClient.post('/api/workouts', 
    body: workoutData);
```

### 3. Exception Handling

Comprehensive exception handling with custom exception classes:

- `NetworkException`: Network-related errors
- `ServerException`: Server-side errors
- `CacheException`: Local storage errors
- `ValidationException`: Validation errors
- `ParseException`: JSON parsing errors

### 4. Dynamic Theming

Themes are loaded from JSON files and can be switched programmatically:

```dart
// Theme is loaded automatically on app start
final themeService = getIt<ThemeService>();
await themeService.loadThemes();
```

### 5. Modular Widget Architecture

Each UI component is broken down into smaller, reusable widgets:

- `ExerciseCircleItem`: Individual exercise circle
- `HorizontalExerciseList`: Scrollable exercise list
- `ExerciseDetailsPanel`: Exercise information display
- `EditModeControls`: Save/Discard buttons
- `EquipmentBadge`: Equipment type display

## Usage

### Normal Mode

1. **View Exercises**: Scroll horizontally through the exercise list
2. **Select Exercise**: Tap on any exercise to view details
3. **View Details**: See exercise name, animated GIF, equipment, and action buttons

### Edit Mode

1. **Enter Edit Mode**: Long press on an exercise or tap the edit button
2. **Reorder Exercises**: Drag exercises to reorder them
3. **Remove Exercises**: Tap the minus (-) button on any exercise
4. **Save Changes**: Tap "Save Changes" to persist modifications
5. **Discard Changes**: Tap "Discard" to cancel all modifications

### Exercise States

- **Not Started**: Default state with static image
- **In Progress**: Current exercise with play button overlay
- **Completed**: Finished exercise with green checkmark

## Data Management

### Data Loading Strategy

The app uses a hybrid approach for data loading:

1. **Local Storage First**: Checks SharedPreferences for user-modified workout data
2. **API Fallback**: Loads from JSON server API if no local data exists
3. **Asset Fallback**: Uses bundled asset files if API is unavailable

### JSON Server Development API

The app includes a JSON server setup for development and testing:

```bash
# Start the JSON server
json-server --watch server/db.json --port 3000
```

**Available Endpoints:**

- `GET /workouts` - Returns the complete workout object with name and exercises
- `PUT /workouts` - Update the entire workout (including adding new exercises)
- `POST /exercises` - Create a new exercise (if supported by JSON server)
- `PUT /exercises/:id` - Update an existing exercise
- `DELETE /exercises/:id` - Delete an exercise

**API Configuration:**

- Base URL: `http://localhost:3000`
- Content-Type: `application/json`
- Port: 3000 (configurable)

### Data Persistence

- **User Changes**: Automatically saved to local storage
- **API Integration**: Seamlessly loads fresh data from server
- **Offline Support**: Falls back to cached data when API is unavailable

## Data Model

### Exercise Model

```dart
class Exercise {
  final String name;
  final String assetUrl;      // Static image URL
  final String gifAssetUrl;   // Animated GIF URL
  final String equipment;     // Equipment type
  final String status;        // 'not_started', 'in_progress', 'completed'
  final int order;           // Display order
}
```

### Workout Model

```dart
class Workout {
  final String workoutName;
  final List<Exercise> exercises;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
```

## Customization

### Adding New Equipment Types

1. Add the equipment type to `AppConstants.equipmentIcons`
2. Add the corresponding icon asset
3. Update the `EquipmentBadge` widget formatting logic

### Extending API Client

The generic API client can be extended with additional HTTP methods or custom headers:

```dart
// Add authentication headers
final headers = {'Authorization': 'Bearer $token'};
await apiClient.get('/api/protected', headers: headers);
```

### Custom Themes

Create new theme JSON files in `assets/themes/` and load them via `ThemeService`:

```json
{
  "colors": {
    "primary": "#007AFF",
    "secondary": "#FF9500",
    // ... more colors
  },
  "textStyles": {
    "headlineLarge": {
      "fontSize": 24.0,
      "fontWeight": 6,
      "color": "#000000"
    }
    // ... more text styles
  }
}
```

## Testing

Run tests with:

```bash
flutter test
```

The app includes basic widget tests and can be extended with:

- Unit tests for BLoC logic
- Integration tests for user workflows
- Golden tests for UI consistency

## Performance Considerations

- **Image Caching**: Uses `cached_network_image` for efficient image loading
- **State Management**: BLoC pattern prevents unnecessary rebuilds
- **Local Storage**: SharedPreferences for fast data persistence
- **Lazy Loading**: Images are loaded on demand

## Future Enhancements

- [ ] Add exercise timing and rest periods
- [ ] Implement workout history and analytics
- [ ] Add exercise filtering and search
- [ ] Support for custom exercise creation
- [ ] Integration with fitness tracking APIs
- [ ] Offline mode with data synchronization
- [ ] Voice commands and accessibility features

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email support@example.com or open an issue in the repository.

---

**Built with Flutter & ❤️**
