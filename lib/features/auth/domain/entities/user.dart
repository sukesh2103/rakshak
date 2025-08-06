import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final bool isEmailVerified;
  final String? profileImageUrl;
  final Map<String, dynamic>? preferences;
  
  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.createdAt,
    this.lastLoginAt,
    this.isEmailVerified = false,
    this.profileImageUrl,
    this.preferences,
  });
  
  @override
  List<Object?> get props => [
    id,
    email,
    name,
    phoneNumber,
    createdAt,
    lastLoginAt,
    isEmailVerified,
    profileImageUrl,
    preferences,
  ];
  
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isEmailVerified,
    String? profileImageUrl,
    Map<String, dynamic>? preferences,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      preferences: preferences ?? this.preferences,
    );
  }
}