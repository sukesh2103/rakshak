import 'package:flutter/material.dart';

class EmergencyQuickActions extends StatelessWidget {
  const EmergencyQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            icon: Icons.local_hospital,
            label: 'Medical',
            color: Colors.red,
            onTap: () => _makeEmergencyCall('911'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.local_fire_department,
            label: 'Fire',
            color: Colors.orange,
            onTap: () => _makeEmergencyCall('911'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.local_police,
            label: 'Police',
            color: Colors.blue,
            onTap: () => _makeEmergencyCall('911'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.warning,
            label: 'Emergency',
            color: Colors.purple,
            onTap: () => _makeEmergencyCall('911'),
          ),
        ),
      ],
    );
  }
  
  void _makeEmergencyCall(String number) {
    // TODO: Implement actual phone call functionality
    // You'll need to add url_launcher package and implement phone calls
    print('Emergency call to: $number');
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  
  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                radius: 24,
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}