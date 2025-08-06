// File: lib/features/auth/domain/usecases/login_user.dart
// WORK REQUIRED: Implement authentication use cases with Firebase Auth

import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUser implements UseCase<User, LoginParams> {
  final AuthRepository repository;
  
  LoginUser(this.repository);
  
  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;
  
  LoginParams({
    required this.email,
    required this.password,
  });
}

// File: lib/features/auth/domain/usecases/register_user.dart
class RegisterUser implements UseCase<User, RegisterParams> {
  final AuthRepository repository;
  
  RegisterUser(this.repository);
  
  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(
      params.email,
      params.password,
      params.name,
      params.phoneNumber,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  
  RegisterParams({
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
  });
}

// File: lib/features/auth/domain/usecases/logout_user.dart
class LogoutUser implements UseCase<void, NoParams> {
  final AuthRepository repository;
  
  LogoutUser(this.repository);
  
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}

// File: lib/features/auth/domain/repositories/auth_repository.dart
abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String email, String password, String name, String phoneNumber);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCurrentUser();
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  Future<Either<Failure, User>> updateProfile(String userId, Map<String, dynamic> updates);
}

/*
FIREBASE AUTH INTEGRATION POINTS:
1. Configure Firebase Authentication in your Firebase Console
2. Enable Email/Password sign-in method
3. Set up authentication state persistence
4. Implement user profile management in Firestore
5. Add email verification workflow
6. Configure password reset functionality
7. Set up custom claims for role-based access
8. Implement session management and token refresh

BACKEND API ENDPOINTS (if using custom backend):
- POST /auth/login - User login
- POST /auth/register - User registration  
- POST /auth/logout - User logout
- GET /auth/profile - Get user profile
- PUT /auth/profile - Update user profile
- POST /auth/forgot-password - Password reset
- POST /auth/verify-email - Email verification
- POST /auth/refresh-token - Token refresh

SECURITY CONSIDERATIONS:
- Implement proper input validation
- Use secure password requirements
- Add rate limiting for login attempts
- Implement account lockout after failed attempts
- Add two-factor authentication (2FA) support
- Encrypt sensitive user data
- Implement proper session management
*/