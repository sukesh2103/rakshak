import 'package:flutter/material.dart';

class RecentAlertsWidget extends StatelessWidget {
  const RecentAlertsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data from backend
    final alerts = _getDummyAlerts();
    
    if (alerts.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 48,
                color: Colors.green,
              ),
              const SizedBox(height: 12),
              const Text(
                'No Active Alerts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your area is currently safe',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    return Column(
      children: alerts.map((alert) => _AlertCard(alert: alert)).toList(),
    );
  }
  
  List<AlertData> _getDummyAlerts() {
    // TODO: Replace with actual API call
    return [
      AlertData(
        id: '1',
        title: 'Severe Weather Warning',
        description: 'Heavy rain and strong winds expected',
        severity: AlertSeverity.medium,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: 'Weather',
      ),
      AlertData(
        id: '2',
        title: 'Flood Advisory',
        description: 'Minor flooding possible in low-lying areas',
        severity: AlertSeverity.low,
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        type: 'Flood',
      ),
    ];
  }
}

class _AlertCard extends StatelessWidget {
  final AlertData alert;
  
  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getSeverityColor(alert.severity).withOpacity(0.1),
          child: Icon(
            _getSeverityIcon(alert.severity),
            color: _getSeverityColor(alert.severity),
          ),
        ),
        title: Text(
          alert.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(alert.description),
            const SizedBox(height: 4),
            Text(
              '${alert.type} • ${_formatTimestamp(alert.timestamp)}',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
        onTap: () {
          // TODO: Navigate to alert details
        },
      ),
    );
  }
  
  Color _getSeverityColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.high:
        return Colors.red;
      case AlertSeverity.medium:
        return Colors.orange;
      case AlertSeverity.low:
        return Colors.yellow.shade700;
    }
  }
  
  IconData _getSeverityIcon(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.high:
        return Icons.error;
      case AlertSeverity.medium:
        return Icons.warning;
      case AlertSeverity.low:
        return Icons.info;
    }
  }
  
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

class AlertData {
  final String id;
  final String title;
  final String description;
  final AlertSeverity severity;
  final DateTime timestamp;
  final String type;
  
  AlertData({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.timestamp,
    required this.type,
  });
}

enum AlertSeverity { low, medium, high }