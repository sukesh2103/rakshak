import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/emergency_contact.dart';
import '../../domain/usecases/get_emergency_contacts.dart';
import '../../domain/usecases/add_emergency_contact.dart';
import '../../domain/usecases/delete_emergency_contact.dart';

// Events
abstract class EmergencyContactsEvent extends Equatable {
  const EmergencyContactsEvent();
  
  @override
  List<Object?> get props => [];
}

class EmergencyContactsLoaded extends EmergencyContactsEvent {}

class EmergencyContactAdded extends EmergencyContactsEvent {
  final EmergencyContact contact;
  
  const EmergencyContactAdded(this.contact);
  
  @override
  List<Object?> get props => [contact];
}

class EmergencyContactUpdated extends EmergencyContactsEvent {
  final EmergencyContact contact;
  
  const EmergencyContactUpdated(this.contact);
  
  @override
  List<Object?> get props => [contact];
}

class EmergencyContactDeleted extends EmergencyContactsEvent {
  final String contactId;
  
  const EmergencyContactDeleted(this.contactId);
  
  @override
  List<Object?> get props => [contactId];
}

// States
abstract class EmergencyContactsState extends Equatable {
  const EmergencyContactsState();
  
  @override
  List<Object?> get props => [];
}

class EmergencyContactsInitial extends EmergencyContactsState {}

class EmergencyContactsLoading extends EmergencyContactsState {}

class EmergencyContactsLoaded extends EmergencyContactsState {
  final List<EmergencyContact> contacts;
  
  const EmergencyContactsLoaded(this.contacts);
  
  @override
  List<Object?> get props => [contacts];
}

class EmergencyContactsError extends EmergencyContactsState {
  final String message;
  
  const EmergencyContactsError(this.message);
  
  @override
  List<Object?> get props => [message];
}

// Bloc
class EmergencyContactsBloc extends Bloc<EmergencyContactsEvent, EmergencyContactsState> {
  final GetEmergencyContacts _getEmergencyContacts;
  final AddEmergencyContact _addEmergencyContact;
  final DeleteEmergencyContact _deleteEmergencyContact;
  
  EmergencyContactsBloc({
    required GetEmergencyContacts getEmergencyContacts,
    required AddEmergencyContact addEmergencyContact,
    required DeleteEmergencyContact deleteEmergencyContact,
  }) : _getEmergencyContacts = getEmergencyContacts,
       _addEmergencyContact = addEmergencyContact,
       _deleteEmergencyContact = deleteEmergencyContact,
       super(EmergencyContactsInitial()) {
    
    on<EmergencyContactsLoaded>(_onEmergencyContactsLoaded);
    on<EmergencyContactAdded>(_onEmergencyContactAdded);
    on<EmergencyContactDeleted>(_onEmergencyContactDeleted);
  }
  
  Future<void> _onEmergencyContactsLoaded(
    EmergencyContactsLoaded event,
    Emitter<EmergencyContactsState> emit,
  ) async {
    emit(EmergencyContactsLoading());
    
    try {
      final result = await _getEmergencyContacts(NoParams());
      
      result.fold(
        (failure) => emit(EmergencyContactsError(failure.message)),
        (contacts) => emit(EmergencyContactsLoaded(contacts)),
      );
    } catch (e) {
      emit(const EmergencyContactsError('An unexpected error occurred'));
    }
  }
  
  Future<void> _onEmergencyContactAdded(
    EmergencyContactAdded event,
    Emitter<EmergencyContactsState> emit,
  ) async {
    try {
      final result = await _addEmergencyContact(AddContactParams(contact: event.contact));
      
      result.fold(
        (failure) => emit(EmergencyContactsError(failure.message)),
        (_) {
          // Reload contacts after adding
          add(EmergencyContactsLoaded());
        },
      );
    } catch (e) {
      emit(const EmergencyContactsError('Failed to add contact'));
    }
  }
  
  Future<void> _onEmergencyContactDeleted(
    EmergencyContactDeleted event,
    Emitter<EmergencyContactsState> emit,
  ) async {
    try {
      final result = await _deleteEmergencyContact(DeleteContactParams(contactId: event.contactId));
      
      result.fold(
        (failure) => emit(EmergencyContactsError(failure.message)),
        (_) {
          // Reload contacts after deleting
          add(EmergencyContactsLoaded());
        },
      );
    } catch (e) {
      emit(const EmergencyContactsError('Failed to delete contact'));
    }
  }
}

// Use case parameters
class NoParams {}

class AddContactParams {
  final EmergencyContact contact;
  
  AddContactParams({required this.contact});
}

class DeleteContactParams {
  final String contactId;
  
  DeleteContactParams({required this.contactId});
}