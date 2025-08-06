// File: lib/core/injection/injection_container.dart
// WORK REQUIRED: Configure dependency injection for backend services

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

// Import your service classes (you'll need to implement these)
import '../services/api_service.dart';
import '../services/bluetooth_service.dart';
import '../services/storage_service.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_user.dart';
import '../../features/auth/domain/usecases/register_user.dart';
import '../../features/auth/domain/usecases/logout_user.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

// Emergency Contacts
import '../../features/emergency_contacts/data/datasources/emergency_contacts_remote_data_source.dart';
import '../../features/emergency_contacts/data/repositories/emergency_contacts_repository_impl.dart';
import '../../features/emergency_contacts/domain/repositories/emergency_contacts_repository.dart';
import '../../features/emergency_contacts/domain/usecases/get_emergency_contacts.dart';
import '../../features/emergency_contacts/domain/usecases/add_emergency_contact.dart';
import '../../features/emergency_contacts/domain/usecases/delete_emergency_contact.dart';
import '../../features/emergency_contacts/presentation/bloc/emergency_contacts_bloc.dart';

// Theme
import '../../features/theme/data/datasources/theme_local_data_source.dart';
import '../../features/theme/data/repositories/theme_repository_impl.dart';
import '../../features/theme/domain/repositories/theme_repository.dart';
import '../../features/theme/domain/usecases/get_theme_preference.dart';
import '../../features/theme/domain/usecases/save_theme_preference.dart';
import '../../features/theme/presentation/bloc/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  
  // Auth
  _initAuth();
  
  // Emergency Contacts
  _initEmergencyContacts();
  
  // Theme
  _initTheme();
  
  //! Core Services
  _initCore();
  
  //! External Dependencies
  await _initExternal();
}

void _initAuth() {
  // Bloc
  sl.registerFactory(() => AuthBloc(
    loginUser: sl(),
    registerUser: sl(),
    logoutUser: sl(),
  ));
  
  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      apiService: sl(),
      firebaseAuth: sl(),
    ),
  );
}

void _initEmergencyContacts() {
  // Bloc
  sl.registerFactory(() => EmergencyContactsBloc(
    getEmergencyContacts: sl(),
    addEmergencyContact: sl(),
    deleteEmergencyContact: sl(),
  ));
  
  // Use cases
  sl.registerLazySingleton(() => GetEmergencyContacts(sl()));
  sl.registerLazySingleton(() => AddEmergencyContact(sl()));
  sl.registerLazySingleton(() => DeleteEmergencyContact(sl()));
  
  // Repository
  sl.registerLazySingleton<EmergencyContactsRepository>(
    () => EmergencyContactsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  
  // Data sources
  sl.registerLazySingleton<EmergencyContactsRemoteDataSource>(
    () => EmergencyContactsRemoteDataSourceImpl(
      apiService: sl(),
      firestore: sl(),
    ),
  );
}

void _initTheme() {
  // Bloc
  sl.registerFactory(() => ThemeBloc(
    getThemePreference: sl(),
    saveThemePreference: sl(),
  ));
  
  // Use cases
  sl.registerLazySingleton(() => GetThemePreference(sl()));
  sl.registerLazySingleton(() => SaveThemePreference(sl()));
  
  // Repository
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(localDataSource: sl()),
  );
  
  // Data sources
  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(sharedPreferences: sl()),
  );
}

void _initCore() {
  // Services
  sl.registerLazySingleton<ApiService>(() => ApiServiceImpl(dio: sl()));
  sl.registerLazySingleton<BluetoothService>(() => BluetoothServiceImpl());
  sl.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  
  // Network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

Future<void> _initExternal() async {
  // External packages
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  sl.registerLazySingleton(() => Connectivity());
  
  // Dio for HTTP requests
  final dio = Dio();
  dio.options.baseUrl = 'https://your-api-domain.com/api/v1'; // TODO: Replace with actual API URL
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  sl.registerLazySingleton(() => dio);
  
  // Firebase instances (you'll get these from Firebase setup)
  // TODO: Initialize Firebase Auth and Firestore instances
  // sl.registerLazySingleton(() => FirebaseAuth.instance);
  // sl.registerLazySingleton(() => FirebaseFirestore.instance);
}

// TODO: Implement these classes in their respective files
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  
  NetworkInfoImpl(this.connectivity);
  
  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}

/*
BACKEND INTEGRATION POINTS:
1. Replace API base URL with your actual backend endpoint
2. Configure Firebase Auth and Firestore instances
3. Implement authentication endpoints
4. Set up Firestore security rules
5. Configure push notification tokens
6. Implement API error handling and retry logic
7. Add request/response interceptors for authentication
8. Set up offline caching strategy
*/