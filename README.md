# Workout Planner

A Flutter mobile app that helps you plan and track your workout sessions with an intuitive interface for managing exercises.

## About the App

Workout Planner is a simple yet powerful fitness app that allows you to:
- View your workout exercises in a horizontal scrollable list
- Track exercise progress (not started, in progress, completed)
- Edit and reorder exercises through an edit mode
- See exercise details with GIF animations
- Add new exercises with custom images and equipment types

The app supports various equipment types including barbells, dumbbells, cables, and bodyweight exercises.

## Video Demo
[Watch the setup and run guide here](https://www.loom.com/share/9da62b2fb3fb41f1b41ec74514566bb6?sid=0817c0ba-a9d3-40aa-a585-4ebdaea868ed)


## Requirements

- Flutter SDK (>=3.8.0)
- Dart SDK
- iOS Simulator/Device or Android Emulator/Device
- Node.js (for running the local JSON server)

## Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/Fasikawkn/workout_planner.git
cd workout_planner
```

### 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 3. Generate Code
The app uses code generation for JSON serialization. Run:
```bash
flutter packages pub run build_runner build
```

### 4. Start the Local JSON Server
The app uses a local JSON server for data storage. In a new terminal, navigate to the project directory and run:
```bash
# Install json-server globally if you haven't already
npm install -g json-server

# Start the server
cd server
json-server --watch db.json --port 3000
```

The server will start at `http://localhost:3000` and serve the workout data.

### 5. Run the App

#### For iOS:
```bash
flutter run -d ios
```

#### For Android:
```bash
flutter run -d android
```


## Development

### Architecture
The app follows clean architecture principles with:
- **BLoC Pattern**: For state management
- **Dependency Injection**: Using GetIt and Injectable
- **Feature-based Structure**: Modular organization


## Troubleshooting

### Common Issues

1. **Build runner errors**: Run `flutter clean` then `flutter pub get` and `flutter packages pub run build_runner build --delete-conflicting-outputs`

2. **JSON Server not running**: Make sure the server is running on port 3000 before launching the app

3. **Network errors**: Ensure your device/emulator can access `http://localhost:3000` for iOS simulator and `http://10.0.2.2:3000` for android emulator

4. **iOS build issues**: Run `cd ios && pod install` to update CocoaPods dependencies




