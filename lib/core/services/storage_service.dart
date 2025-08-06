import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

/// Service for handling local data storage
class StorageService {
  static const String _emergencyContactsBox = 'emergency_contacts';
  static const String _userPreferencesBox = 'user_preferences';
  static const String _cacheBox = 'cache';
  
  late Box _emergencyContactsBox_;
  late Box _userPreferencesBox_;
  late Box _cacheBox_;
  late SharedPreferences _prefs;
  
  /// Initialize storage service
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Open Hive boxes
    _emergencyContactsBox_ = await Hive.openBox(_emergencyContactsBox);
    _userPreferencesBox_ = await Hive.openBox(_userPreferencesBox);
    _cacheBox_ = await Hive.openBox(_cacheBox);
  }
  
  // Emergency Contacts Storage
  Future<void> saveEmergencyContacts(List<Map<String, dynamic>> contacts) async {
    await _emergencyContactsBox_.put('contacts', contacts);
  }
  
  List<Map<String, dynamic>> getEmergencyContacts() {
    final contacts = _emergencyContactsBox_.get('contacts', defaultValue: <Map<String, dynamic>>[]);
    return List<Map<String, dynamic>>.from(contacts);
  }
  
  Future<void> addEmergencyContact(Map<String, dynamic> contact) async {
    final contacts = getEmergencyContacts();
    contacts.add(contact);
    await saveEmergencyContacts(contacts);
  }
  
  Future<void> removeEmergencyContact(String contactId) async {
    final contacts = getEmergencyContacts();
    contacts.removeWhere((contact) => contact['id'] == contactId);
    await saveEmergencyContacts(contacts);
  }
  
  // User Preferences Storage
  Future<void> saveThemePreference(bool isDarkMode) async {
    await _prefs.setBool('isDarkMode', isDarkMode);
  }
  
  bool getThemePreference() {
    return _prefs.getBool('isDarkMode') ?? false;
  }
  
  Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    await _userPreferencesBox_.put('profile', profile);
  }
  
  Map<String, dynamic>? getUserProfile() {
    final profile = _userPreferencesBox_.get('profile');
    return profile != null ? Map<String, dynamic>.from(profile) : null;
  }
  
  // Cache Management
  Future<void> cacheData(String key, dynamic data) async {
    await _cacheBox_.put(key, data);
  }
  
  T? getCachedData<T>(String key) {
    return _cacheBox_.get(key);
  }
  
  Future<void> clearCache() async {
    await _cacheBox_.clear();
  }
  
  // General SharedPreferences methods
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }
  
  String? getString(String key) {
    return _prefs.getString(key);
  }
  
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }
  
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }
  
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }
  
  int? getInt(String key) {
    return _prefs.getInt(key);
  }
  
  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }
  
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }
  
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
  
  Future<void> clear() async {
    await _prefs.clear();
    await _emergencyContactsBox_.clear();
    await _userPreferencesBox_.clear();
    await _cacheBox_.clear();
  }
}