import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/emergency_contact.dart';
import '../bloc/emergency_contacts_bloc.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';
import '../../../auth/presentation/widgets/auth_button.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  
  String _selectedRelationship = 'Family';
  bool _isPrimary = false;
  
  final List<String> _relationships = [
    'Family',
    'Friend',
    'Colleague',
    'Doctor',
    'Neighbor',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      final contact = EmergencyContact(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
        relationship: _selectedRelationship,
        address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
        isPrimary: _isPrimary,
        createdAt: DateTime.now(),
      );
      
      context.read<EmergencyContactsBloc>().add(EmergencyContactAdded(contact));
      context.go('/emergency-contacts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Emergency Contact'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/emergency-contacts'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_add,
                        size: 48,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Add Emergency Contact',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'This person will be contacted in case of emergency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Name Field
              AuthTextField(
                controller: _nameController,
                label: 'Full Name *',
                hintText: 'Enter contact\'s full name',
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the contact\'s name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Phone Field
              AuthTextField(
                controller: _phoneController,
                label: 'Phone Number *',
                hintText: 'Enter phone number',
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone_outlined,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a phone number';
                  }
                  if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(value.trim())) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Email Field (Optional)
              AuthTextField(
                controller: _emailController,
                label: 'Email Address (Optional)',
                hintText: 'Enter email address',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Relationship Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Relationship *',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedRelationship,
                    decoration: InputDecoration(
                      hintText: 'Select relationship',
                      prefixIcon: const Icon(Icons.people_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                    ),
                    items: _relationships.map((relationship) {
                      return DropdownMenuItem<String>(
                        value: relationship,
                        child: Text(relationship),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedRelationship = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Address Field (Optional)
              AuthTextField(
                controller: _addressController,
                label: 'Address (Optional)',
                hintText: 'Enter address',
                prefixIcon: Icons.location_on_outlined,
                keyboardType: TextInputType.multiline,
              ),
              
              const SizedBox(height: 24),
              
              // Primary Contact Toggle
              Card(
                child: SwitchListTile(
                  title: const Text(
                    'Primary Contact',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text(
                    'Primary contacts are contacted first in emergencies',
                  ),
                  value: _isPrimary,
                  onChanged: (value) {
                    setState(() {
                      _isPrimary = value;
                    });
                  },
                  secondary: Icon(
                    _isPrimary ? Icons.star : Icons.star_border,
                    color: _isPrimary ? Colors.amber : null,
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Save Button
              BlocBuilder<EmergencyContactsBloc, EmergencyContactsState>(
                builder: (context, state) {
                  return AuthButton(
                    text: 'Save Contact',
                    onPressed: state is EmergencyContactsLoading ? null : _saveContact,
                    isLoading: state is EmergencyContactsLoading,
                  );
                },
              ),
              
              const SizedBox(height: 16),
              
              // Cancel Button
              OutlinedButton(
                onPressed: () => context.go('/emergency-contacts'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}