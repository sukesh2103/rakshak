import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/emergency_contacts/presentation/pages/emergency_contacts_page.dart';
import '../../features/emergency_contacts/presentation/pages/add_contact_page.dart';
import '../../features/alerting/presentation/pages/alerting_page.dart';
import '../../features/mitigation/presentation/pages/mitigation_page.dart';
import '../../features/relief/presentation/pages/relief_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      // Authentication Routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      
      // Main App Routes
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      
      // Emergency Contacts Routes
      GoRoute(
        path: '/emergency-contacts',
        name: 'emergency-contacts',
        builder: (context, state) => const EmergencyContactsPage(),
      ),
      GoRoute(
        path: '/add-contact',
        name: 'add-contact',
        builder: (context, state) => const AddContactPage(),
      ),
      
      // Feature Module Routes
      GoRoute(
        path: '/alerting',
        name: 'alerting',
        builder: (context, state) => const AlertingPage(),
      ),
      GoRoute(
        path: '/mitigation',
        name: 'mitigation',
        builder: (context, state) => const MitigationPage(),
      ),
      GoRoute(
        path: '/relief',
        name: 'relief',
        builder: (context, state) => const ReliefPage(),
      ),
      
      // Profile Route
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.location}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}