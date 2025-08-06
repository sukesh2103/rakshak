import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/emergency_contacts_bloc.dart';
import '../../domain/entities/emergency_contact.dart';
import '../widgets/contact_card.dart';

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({super.key});

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  @override
  void initState() {
    super.initState();
    context.read<EmergencyContactsBloc>().add(EmergencyContactsLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<EmergencyContactsBloc, EmergencyContactsState>(
        builder: (context, state) {
          if (state is EmergencyContactsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (state is EmergencyContactsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading contacts',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<EmergencyContactsBloc>().add(EmergencyContactsLoaded());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          
          if (state is EmergencyContactsLoaded) {
            final contacts = state.contacts;
            
            if (contacts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.contacts_outlined,
                      size: 64,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No Emergency Contacts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add emergency contacts to quickly reach help when needed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.go('/add-contact'),
                      icon: const Icon(Icons.add),
                      label: const Text('Add First Contact'),
                    ),
                  ],
                ),
              );
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                context.read<EmergencyContactsBloc>().add(EmergencyContactsLoaded());
              },
              child: Column(
                children: [
                  // Primary Contacts Section
                  if (contacts.any((c) => c.isPrimary)) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Text(
                        'Primary Contacts',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: contacts.where((c) => c.isPrimary).length,
                      itemBuilder: (context, index) {
                        final primaryContacts = contacts.where((c) => c.isPrimary).toList();
                        return ContactCard(
                          contact: primaryContacts[index],
                          onEdit: () => _editContact(primaryContacts[index]),
                          onDelete: () => _deleteContact(primaryContacts[index]),
                          onCall: () => _callContact(primaryContacts[index]),
                        );
                      },
                    ),
                    const Divider(height: 1),
                  ],
                  
                  // Other Contacts Section
                  if (contacts.any((c) => !c.isPrimary)) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'Other Contacts',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: contacts.where((c) => !c.isPrimary).length,
                        itemBuilder: (context, index) {
                          final otherContacts = contacts.where((c) => !c.isPrimary).toList();
                          return ContactCard(
                            contact: otherContacts[index],
                            onEdit: () => _editContact(otherContacts[index]),
                            onDelete: () => _deleteContact(otherContacts[index]),
                            onCall: () => _callContact(otherContacts[index]),
                          );
                        },
                      ),
                    ),
                  ] else if (contacts.isNotEmpty) ...[
                    const Expanded(child: SizedBox()),
                  ],
                ],
              ),
            );
          }
          
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add-contact'),
        child: const Icon(Icons.add),
      ),
    );
  }
  
  void _editContact(EmergencyContact contact) {
    // TODO: Navigate to edit contact page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit contact feature coming soon')),
    );
  }
  
  void _deleteContact(EmergencyContact contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text('Are you sure you want to delete ${contact.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<EmergencyContactsBloc>().add(
                EmergencyContactDeleted(contact.id),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
  
  void _callContact(EmergencyContact contact) {
    // TODO: Implement phone call functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling ${contact.name}...')),
    );
  }
}