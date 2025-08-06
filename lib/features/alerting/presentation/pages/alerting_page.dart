import 'package:flutter/material.dart';

class AlertingPage extends StatefulWidget {
  const AlertingPage({super.key});

  @override
  State<AlertingPage> createState() => _AlertingPageState();
}

class _AlertingPageState extends State<AlertingPage> with TickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerting & Prediction'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active Alerts'),
            Tab(text: 'Predictions'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ActiveAlertsTab(),
          _PredictionsTab(),
          _AlertHistoryTab(),
        ],
      ),
    );
  }
}

class _ActiveAlertsTab extends StatelessWidget {
  const _ActiveAlertsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Emergency Alert Status
          Card(
            color: Colors.green.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'All Clear',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'No active emergency alerts in your area',
                          style: TextStyle(
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          const Text(
            'Recent Alerts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Recent alerts list
          _buildAlertCard(
            title: 'Severe Weather Warning',
            description: 'Heavy rain and strong winds expected',
            time: '2 hours ago',
            severity: AlertSeverity.medium,
            type: 'Weather',
          ),
          
          _buildAlertCard(
            title: 'Road Closure Advisory',
            description: 'Main Street closed due to construction',
            time: '6 hours ago',
            severity: AlertSeverity.low,
            type: 'Traffic',
          ),
          
          _buildAlertCard(
            title: 'Air Quality Alert',
            description: 'Poor air quality due to wildfires',
            time: '1 day ago',
            severity: AlertSeverity.medium,
            type: 'Health',
          ),
        ],
      ),
    );
  }
  
  Widget _buildAlertCard({
    required String title,
    required String description,
    required String time,
    required AlertSeverity severity,
    required String type,
  }) {
    Color severityColor;
    IconData severityIcon;
    
    switch (severity) {
      case AlertSeverity.high:
        severityColor = Colors.red;
        severityIcon = Icons.error;
        break;
      case AlertSeverity.medium:
        severityColor = Colors.orange;
        severityIcon = Icons.warning;
        break;
      case AlertSeverity.low:
        severityColor = Colors.yellow.shade700;
        severityIcon = Icons.info;
        break;
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: severityColor.withOpacity(0.1),
          child: Icon(severityIcon, color: severityColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: severityColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      fontSize: 10,
                      color: severityColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: Navigate to alert details
        },
      ),
    );
  }
}

class _PredictionsTab extends StatelessWidget {
  const _PredictionsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AI-Powered Predictions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Prediction cards
          _buildPredictionCard(
            title: 'Weather Forecast',
            prediction: 'Light rain expected tomorrow afternoon',
            confidence: 85,
            timeframe: 'Next 24 hours',
            icon: Icons.cloud_outlined,
            color: Colors.blue,
          ),
          
          _buildPredictionCard(
            title: 'Traffic Conditions',
            prediction: 'Heavy traffic expected during rush hour',
            confidence: 92,
            timeframe: 'Today 5-7 PM',
            icon: Icons.traffic,
            color: Colors.orange,
          ),
          
          _buildPredictionCard(
            title: 'Air Quality',
            prediction: 'Good air quality expected this week',
            confidence: 78,
            timeframe: 'Next 7 days',
            icon: Icons.air,
            color: Colors.green,
          ),
          
          const SizedBox(height: 24),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'AI Insights',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Based on historical data and current conditions, our AI system provides predictive insights to help you prepare for potential emergencies.',
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Navigate to AI insights details
                    },
                    child: const Text('Learn More'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPredictionCard({
    required String title,
    required String prediction,
    required int confidence,
    required String timeframe,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        timeframe,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$confidence% confidence',
                    style: TextStyle(
                      fontSize: 10,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(prediction),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: confidence / 100,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertHistoryTab extends StatelessWidget {
  const _AlertHistoryTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Alert History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // TODO: Implement filter functionality
                },
                icon: const Icon(Icons.filter_list),
                label: const Text('Filter'),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // History timeline
          _buildHistoryItem(
            date: 'March 15, 2024',
            title: 'Earthquake Alert',
            description: 'Magnitude 4.2 earthquake detected',
            severity: AlertSeverity.high,
            wasResolved: true,
          ),
          
          _buildHistoryItem(
            date: 'March 12, 2024',
            title: 'Flash Flood Warning',
            description: 'Heavy rainfall causing flooding',
            severity: AlertSeverity.high,
            wasResolved: true,
          ),
          
          _buildHistoryItem(
            date: 'March 8, 2024',
            title: 'Air Quality Alert',
            description: 'Unhealthy air quality levels',
            severity: AlertSeverity.medium,
            wasResolved: true,
          ),
          
          _buildHistoryItem(
            date: 'March 5, 2024',
            title: 'Severe Weather Warning',
            description: 'Strong winds and hail expected',
            severity: AlertSeverity.medium,
            wasResolved: true,
          ),
          
          const SizedBox(height: 24),
          
          Center(
            child: OutlinedButton(
              onPressed: () {
                // TODO: Load more history
              },
              child: const Text('Load More'),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHistoryItem({
    required String date,
    required String title,
    required String description,
    required AlertSeverity severity,
    required bool wasResolved,
  }) {
    Color severityColor;
    IconData severityIcon;
    
    switch (severity) {
      case AlertSeverity.high:
        severityColor = Colors.red;
        severityIcon = Icons.error;
        break;
      case AlertSeverity.medium:
        severityColor = Colors.orange;
        severityIcon = Icons.warning;
        break;
      case AlertSeverity.low:
        severityColor = Colors.yellow.shade700;
        severityIcon = Icons.info;
        break;
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: wasResolved 
              ? Colors.grey.withOpacity(0.1)
              : severityColor.withOpacity(0.1),
          child: Icon(
            wasResolved ? Icons.check : severityIcon,
            color: wasResolved ? Colors.grey : severityColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: wasResolved ? Colors.grey : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(
                color: wasResolved ? Colors.grey : null,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  date,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(width: 8),
                if (wasResolved)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Resolved',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: Navigate to alert details
        },
      ),
    );
  }
}

enum AlertSeverity { low, medium, high }