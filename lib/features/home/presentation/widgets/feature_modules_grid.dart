import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeatureModulesGrid extends StatelessWidget {
  const FeatureModulesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: [
        _ModuleCard(
          title: 'Alerting & Prediction',
          subtitle: 'Early warning systems',
          icon: Icons.warning_amber,
          color: Colors.orange,
          onTap: () => context.go('/alerting'),
        ),
        _ModuleCard(
          title: 'Mitigation',
          subtitle: 'Prevention strategies',
          icon: Icons.shield,
          color: Colors.green,
          onTap: () => context.go('/mitigation'),
        ),
        _ModuleCard(
          title: 'Relief & Recovery',
          subtitle: 'Emergency response',
          icon: Icons.healing,
          color: Colors.blue,
          onTap: () => context.go('/relief'),
        ),
        _ModuleCard(
          title: 'Emergency Contacts',
          subtitle: 'Manage contacts',
          icon: Icons.contacts,
          color: Colors.purple,
          onTap: () => context.go('/emergency-contacts'),
        ),
      ],
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  
  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}