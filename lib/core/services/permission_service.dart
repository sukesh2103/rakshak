import 'package:permission_handler/permission_handler.dart';
import '../config/app_config.dart';

/// Service for handling app permissions
class PermissionService {
  /// Request all initial permissions required by the app
  static Future<void> requestInitialPermissions() async {
    // Request notification permission
    await requestNotificationPermission();
    
    // Request location permissions (for emergency services)
    await requestLocationPermission();
    
    // Request storage permissions
    await requestStoragePermission();
    
    // Request Bluetooth permissions
    await requestBluetoothPermission();
  }
  
  /// Request notification permission
  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }
  
  /// Request location permission
  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isDenied) {
      // Request precise location for emergency services
      final preciseStatus = await Permission.locationWhenInUse.request();
      return preciseStatus.isGranted;
    }
    return status.isGranted;
  }
  
  /// Request storage permission
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }
  
  /// Request Bluetooth permission
  static Future<bool> requestBluetoothPermission() async {
    // For Android 12+ (API 31+), we need specific Bluetooth permissions
    final bluetoothConnect = await Permission.bluetoothConnect.request();
    final bluetoothScan = await Permission.bluetoothScan.request();
    final bluetoothAdvertise = await Permission.bluetoothAdvertise.request();
    
    return bluetoothConnect.isGranted && 
           bluetoothScan.isGranted && 
           bluetoothAdvertise.isGranted;
  }
  
  /// Request camera permission
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }
  
  /// Request microphone permission
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }
  
  /// Check if a specific permission is granted
  static Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }
  
  /// Get the status of all critical permissions
  static Future<Map<String, bool>> getPermissionStatuses() async {
    return {
      'notification': await isPermissionGranted(Permission.notification),
      'location': await isPermissionGranted(Permission.location),
      'storage': await isPermissionGranted(Permission.storage),
      'bluetoothConnect': await isPermissionGranted(Permission.bluetoothConnect),
      'bluetoothScan': await isPermissionGranted(Permission.bluetoothScan),
      'camera': await isPermissionGranted(Permission.camera),
      'microphone': await isPermissionGranted(Permission.microphone),
    };
  }
  
  /// Open app settings for manual permission configuration
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }
  
  /// Show permission explanation dialog
  static Future<bool> shouldShowRequestPermissionRationale(Permission permission) async {
    return await permission.shouldShowRequestRationale;
  }
}