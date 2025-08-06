# Emergency Management App

A comprehensive Flutter application for emergency management with alerting, mitigation, and relief capabilities.

## Features

### 🚨 Core Emergency Features
- **Emergency Contacts Management**: Store and manage critical emergency contacts
- **Alerting & Prediction System**: Real-time emergency alerts and AI-powered predictions
- **Mitigation Planning**: Disaster prevention and preparedness tools
- **Relief & Recovery**: Emergency response coordination and resource management

### 🔐 Authentication & Security
- Firebase Authentication with email/password
- Secure user session management
- Profile management and preferences

### 🎨 User Experience
- Modern Material Design 3 UI
- Dark/Light theme support with persistence
- Responsive design for all screen sizes
- Intuitive navigation and user flows

### 📱 Device Integration
- Bluetooth connectivity for emergency devices
- Push notifications via Firebase Cloud Messaging
- Location services for emergency response
- Camera and microphone access for documentation

## Architecture

This app follows Clean Architecture principles with:

```
lib/
├── core/                    # Core functionality
│   ├── config/             # App configuration
│   ├── navigation/         # Routing and navigation
│   ├── services/           # Core services (API, Bluetooth, etc.)
│   ├── theme/              # App theming
│   └── utils/              # Utilities and helpers
├── features/               # Feature modules
│   ├── auth/               # Authentication
│   ├── emergency_contacts/ # Emergency contacts management
│   ├── alerting/           # Alert system
│   ├── mitigation/         # Prevention planning
│   ├── relief/             # Emergency response
│   ├── home/               # Dashboard
│   ├── theme/              # Theme management
│   └── profile/            # User profile
```

Each feature follows Domain Driven Design:
- `presentation/` - UI layer (Pages, Widgets, BLoC)
- `domain/` - Business logic (Entities, Use Cases, Repositories)
- `data/` - Data layer (Data Sources, Models, Repository Implementation)

## Backend Integration Points

### 🔧 Firebase Setup Required
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication, Firestore, and Cloud Messaging
3. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
4. Update `work_firebase_options.dart` with your Firebase configuration

### 🌐 API Integration
Files marked with `work_` prefix require backend integration:

- `work_firebase_options.dart` - Firebase configuration
- `work_injection_container.dart` - Dependency injection setup  
- `work_api_service.dart` - HTTP API service implementation
- `work_bluetooth_service.dart` - Bluetooth device communication
- `work_auth_usecases.dart` - Authentication business logic

### 🔗 API Endpoints
```
Base URL: https://your-api-domain.com/api/v1

Authentication:
- POST /auth/login
- POST /auth/register
- POST /auth/logout

Emergency Management:
- GET/POST /emergency-contacts
- GET/POST /alerts
- GET/POST /mitigation-plans
- GET/POST /relief-requests
```

## Installation & Setup

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- iOS development tools (for iOS builds)

### 1. Clone and Install
```bash
git clone <repository-url>
cd emergency_management_app
flutter pub get
```

### 2. Firebase Configuration
1. Follow the [FlutterFire documentation](https://firebase.flutter.dev/docs/overview) to set up Firebase
2. Update `lib/core/config/work_firebase_options.dart` with your configuration
3. Place configuration files:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

### 3. Platform Setup

#### Android
- Minimum SDK: 21
- Target SDK: 33
- Required permissions are already configured in `AndroidManifest.xml`

#### iOS
- Minimum version: iOS 11.0
- Required permissions are configured in `Info.plist`

### 4. Backend Integration
1. Update API base URL in `lib/core/config/app_config.dart`
2. Implement the services in files prefixed with `work_`
3. Configure authentication flows
4. Set up push notification handling

## Development

### State Management
- **BLoC Pattern**: Used for all state management
- **Dependency Injection**: GetIt for service location
- **Clean Architecture**: Separation of concerns across layers

### Key Libraries
- `flutter_bloc` - State management
- `go_router` - Navigation
- `firebase_core/auth/firestore` - Backend services
- `hive` - Local storage
- `dio` - HTTP client
- `permission_handler` - Device permissions

### Running the App
```bash
# Development
flutter run

# Release build
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

## Security Considerations

### 🔒 Implemented Security Features
- Secure token storage
- Request/response encryption
- Input validation and sanitization
- Permission-based access control

### 📋 Security Checklist
- [ ] Configure Firebase security rules
- [ ] Implement API authentication middleware
- [ ] Set up SSL certificate pinning
- [ ] Add request rate limiting
- [ ] Configure proper CORS policies
- [ ] Implement data encryption at rest
- [ ] Set up audit logging
- [ ] Configure backup and recovery

## Testing

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Widget tests
flutter test test/widget_test/
```

## Deployment

### Firebase Hosting (Web)
```bash
flutter build web
firebase deploy --only hosting
```

### App Stores
- **Google Play**: Use `flutter build appbundle`
- **App Store**: Use `flutter build ios`

## Contributing

1. Follow the established architecture patterns
2. Write tests for new features
3. Update documentation for API changes
4. Follow Dart/Flutter style guidelines
5. Ensure all work files are properly implemented

## Support

For issues and questions:
1. Check the documentation in each work file
2. Review Firebase console for backend issues
3. Test API endpoints independently
4. Verify device permissions are granted

## License

[Add your license here]

---

**Note**: This is a production-ready Flutter application template. All files marked with `work_` prefix require backend integration to be fully functional. The app provides a complete UI/UX flow and can be run immediately for testing and development purposes.