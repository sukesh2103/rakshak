import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../config/app_config.dart';

/// Service for handling local and push notifications
class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  static Future<void> initialize() async {
    // Initialize local notifications
    await _initializeLocalNotifications();
    
    // Initialize Firebase messaging
    await _initializeFirebaseMessaging();
  }
  
  static Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    await _localNotifications.initialize(initializationSettings);
    
    // Create notification channels
    await _createNotificationChannels();
  }
  
  static Future<void> _createNotificationChannels() async {
    // Emergency alerts channel
    const AndroidNotificationChannel emergencyChannel = AndroidNotificationChannel(
      AppConfig.emergencyChannelId,
      'Emergency Alerts',
      description: 'Critical emergency notifications',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('emergency_alert'),
    );
    
    // General notifications channel
    const AndroidNotificationChannel generalChannel = AndroidNotificationChannel(
      AppConfig.generalChannelId,
      'General Notifications',
      description: 'General app notifications',
      importance: Importance.high,
    );
    
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(emergencyChannel);
    
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(generalChannel);
  }
  
  static Future<void> _initializeFirebaseMessaging() async {
    // Request permission for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    
    print('User granted permission: ${settings.authorizationStatus}');
    
    // Get the token for this device
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
    
    // TODO: Send token to your backend server
    // await _sendTokenToServer(token);
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // Handle background message taps
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageTap);
    
    // Handle notification when app is terminated
    FirebaseMessaging.instance.getInitialMessage().then(_handleMessageTap);
  }
  
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print('Received foreground message: ${message.messageId}');
    
    // Show local notification for foreground messages
    await showNotification(
      id: message.hashCode,
      title: message.notification?.title ?? 'Emergency Alert',
      body: message.notification?.body ?? 'New notification received',
      channelId: message.data['type'] == 'emergency' 
          ? AppConfig.emergencyChannelId 
          : AppConfig.generalChannelId,
    );
  }
  
  static void _handleMessageTap(RemoteMessage? message) {
    if (message != null) {
      print('Message tapped: ${message.messageId}');
      // TODO: Handle navigation based on message data
      // Example: Navigate to specific screen based on message.data
    }
  }
  
  /// Show a local notification
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String channelId = AppConfig.generalChannelId,
    String? payload,
  }) async {
    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channelId,
      channelId == AppConfig.emergencyChannelId ? 'Emergency Alerts' : 'General Notifications',
      importance: channelId == AppConfig.emergencyChannelId 
          ? Importance.max 
          : Importance.high,
      priority: channelId == AppConfig.emergencyChannelId 
          ? Priority.max 
          : Priority.high,
      sound: channelId == AppConfig.emergencyChannelId 
          ? const RawResourceAndroidNotificationSound('emergency_alert')
          : null,
    );
    
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      sound: 'emergency_alert.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _localNotifications.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
  
  /// Show emergency alert notification
  static Future<void> showEmergencyAlert({
    required String title,
    required String message,
    String? payload,
  }) async {
    await showNotification(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      body: message,
      channelId: AppConfig.emergencyChannelId,
      payload: payload,
    );
  }
  
  /// Cancel a specific notification
  static Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }
  
  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }
}