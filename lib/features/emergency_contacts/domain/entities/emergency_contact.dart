import 'package:equatable/equatable.dart';

class EmergencyContact extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String? email;
  final String relationship;
  final String? address;
  final bool isPrimary;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  const EmergencyContact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.email,
    required this.relationship,
    this.address,
    this.isPrimary = false,
    required this.createdAt,
    this.updatedAt,
  });
  
  @override
  List<Object?> get props => [
    id,
    name,
    phoneNumber,
    email,
    relationship,
    address,
    isPrimary,
    createdAt,
    updatedAt,
  ];
  
  EmergencyContact copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? relationship,
    String? address,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmergencyContact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      relationship: relationship ?? this.relationship,
      address: address ?? this.address,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}