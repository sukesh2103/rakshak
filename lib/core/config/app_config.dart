/// Application configuration constants
class AppConfig {
  // App Information
  static const String appName = 'Emergency Management';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  // TODO: Replace with your actual API endpoints
  static const String baseApiUrl = 'https://your-api-domain.com/api/v1';
  
  // Emergency Management API Endpoints (Dummy URLs for integration)
  static const String emergencyContactsEndpoint = '$baseApiUrl/emergency-contacts';
  static const String alertsEndpoint = '$baseApiUrl/alerts';
  static const String mitigationEndpoint = '$baseApiUrl/mitigation';
  static const String reliefEndpoint = '$baseApiUrl/relief';
  static const String notificationsEndpoint = '$baseApiUrl/notifications';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String emergencyContactsCollection = 'emergency_contacts';
  static const String alertsCollection = 'alerts';
  static const String mitigationPlansCollection = 'mitigation_plans';
  static const String reliefRequestsCollection = 'relief_requests';
  
  // Local Storage Keys
  static const String themePreferenceKey = 'theme_preference';
  static const String userPreferencesKey = 'user_preferences';
  static const String cachedEmergencyContactsKey = 'cached_emergency_contacts';
  
  // Notification Channels
  static const String emergencyChannelId = 'emergency_alerts';
  static const String generalChannelId = 'general_notifications';
  
  // Bluetooth Configuration
  static const String bluetoothServiceUuid = '12345678-1234-5678-9012-123456789abc';
  static const int bluetoothConnectionTimeout = 30; // seconds
  
  // Permissions
  static const List<String> requiredPermissions = [
    'android.permission.BLUETOOTH',
    'android.permission.BLUETOOTH_ADMIN',
    'android.permission.ACCESS_COARSE_LOCATION',
    'android.permission.ACCESS_FINE_LOCATION',
    'android.permission.WRITE_EXTERNAL_STORAGE',
    'android.permission.READ_EXTERNAL_STORAGE',
    'android.permission.CAMERA',
    'android.permission.RECORD_AUDIO',
  ];
}