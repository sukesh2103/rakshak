import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/app_config.dart';
import 'core/config/firebase_options.dart';
import 'core/services/notification_service.dart';
import 'core/services/permission_service.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/theme/presentation/bloc/theme_bloc.dart';
import 'features/emergency_contacts/presentation/bloc/emergency_contacts_bloc.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Initialize dependency injection
  await di.init();
  
  // Initialize services
  await NotificationService.initialize();
  await PermissionService.requestInitialPermissions();
  
  runApp(const EmergencyManagementApp());
}

class EmergencyManagementApp extends StatelessWidget {
  const EmergencyManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>()..add(const AuthCheckRequested()),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => di.sl<ThemeBloc>()..add(ThemeInitialized()),
        ),
        BlocProvider<EmergencyContactsBloc>(
          create: (context) => di.sl<EmergencyContactsBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: 'Emergency Management',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}