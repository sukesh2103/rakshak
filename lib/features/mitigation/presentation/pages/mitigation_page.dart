import 'package:flutter/material.dart';

class MitigationPage extends StatefulWidget {
  const MitigationPage({super.key});

  @override
  State<MitigationPage> createState() => _MitigationPageState();
}

class _MitigationPageState extends State<MitigationPage> with TickerProviderStateMixin {
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
        title: const Text('Mitigation & Prevention'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Plans'),
            Tab(text: 'Resources'),
            Tab(text: 'Training'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _MitigationPlansTab(),
          _ResourcesTab(),
          _TrainingTab(),
        ],
      ),
    );
  }
}

class _MitigationPlansTab extends StatelessWidget {
  const _MitigationPlansTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plan Status Overview
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shield,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Mitigation Plan Status',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _StatusCard(
                          title: 'Completed',
                          count: 12,
                          color: Colors.green,
                          icon: Icons.check_circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatusCard(
                          title: 'In Progress',
                          count: 5,
                          color: Colors.orange,
                          icon: Icons.schedule,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatusCard(
                          title: 'Pending',
                          count: 3,
                          color: Colors.red,
                          icon: Icons.pending,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          const Text(
            'Active Mitigation Plans',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Mitigation plans list
          _buildPlanCard(
            title: 'Home Emergency Kit',
            description: 'Prepare essential supplies for 72 hours',
            progress: 0.8,
            priority: 'High',
            category: 'Preparedness',
            dueDate: 'March 30, 2024',
          ),
          
          _buildPlanCard(
            title: 'Evacuation Route Planning',
            description: 'Identify and practice evacuation routes',
            progress: 0.6,
            priority: 'High',
            category: 'Planning',
            dueDate: 'April 15, 2024',
          ),
          
          _buildPlanCard(
            title: 'Family Communication Plan',
            description: 'Establish communication protocols',
            progress: 1.0,
            priority: 'Medium',
            category: 'Communication',
            dueDate: 'Completed',
          ),
          
          _buildPlanCard(
            title: 'Home Safety Inspection',
            description: 'Conduct safety hazard assessment',
            progress: 0.3,
            priority: 'Medium',
            category: 'Safety',
            dueDate: 'May 1, 2024',
          ),
        ],
      ),
    );
  }
  
  Widget _buildPlanCard({
    required String title,
    required String description,
    required double progress,
    required String priority,
    required String category,
    required String dueDate,
  }) {
    Color priorityColor;
    switch (priority) {
      case 'High':
        priorityColor = Colors.red;
        break;
      case 'Medium':
        priorityColor = Colors.orange;
        break;
      case 'Low':
        priorityColor = Colors.green;
        break;
      default:
        priorityColor = Colors.grey;
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    priority,
                    style: TextStyle(
                      fontSize: 10,
                      color: priorityColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress: ${(progress * 100).toInt()}%',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            category,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progress == 1.0 ? Colors.green : Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Due: $dueDate',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to plan details
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final IconData icon;
  
  const _StatusCard({
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResourcesTab extends StatelessWidget {
  const _ResourcesTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Emergency Resources',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Resource categories
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [
              _ResourceCard(
                title: 'Emergency Supplies',
                subtitle: 'Essential items checklist',
                icon: Icons.inventory,
                color: Colors.blue,
                onTap: () {},
              ),
              _ResourceCard(
                title: 'Safety Equipment',
                subtitle: 'Fire extinguishers, alarms',
                icon: Icons.safety_check,
                color: Colors.red,
                onTap: () {},
              ),
              _ResourceCard(
                title: 'Communication Tools',
                subtitle: 'Radios, backup power',
                icon: Icons.radio,
                color: Colors.green,
                onTap: () {},
              ),
              _ResourceCard(
                title: 'Medical Supplies',
                subtitle: 'First aid, medications',
                icon: Icons.medical_services,
                color: Colors.orange,
                onTap: () {},
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          const Text(
            'Resource Guides',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Guide cards
          _buildGuideCard(
            title: 'Emergency Kit Checklist',
            description: 'Complete list of essential items for your emergency kit',
            duration: '10 min read',
            difficulty: 'Easy',
          ),
          
          _buildGuideCard(
            title: 'Home Safety Assessment',
            description: 'Step-by-step guide to assess your home for hazards',
            duration: '30 min read',
            difficulty: 'Medium',
          ),
          
          _buildGuideCard(
            title: 'Disaster-Proofing Your Home',
            description: 'Advanced techniques to protect your property',
            duration: '45 min read',
            difficulty: 'Advanced',
          ),
        ],
      ),
    );
  }
  
  Widget _buildGuideCard({
    required String title,
    required String description,
    required String duration,
    required String difficulty,
  }) {
    Color difficultyColor;
    switch (difficulty) {
      case 'Easy':
        difficultyColor = Colors.green;
        break;
      case 'Medium':
        difficultyColor = Colors.orange;
        break;
      case 'Advanced':
        difficultyColor = Colors.red;
        break;
      default:
        difficultyColor = Colors.grey;
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Icon(
            Icons.article,
            color: Theme.of(context).primaryColor,
          ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: difficultyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    difficulty,
                    style: TextStyle(
                      fontSize: 10,
                      color: difficultyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  duration,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: Navigate to guide details
        },
      ),
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  
  const _ResourceCard({
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                radius: 24,
                child: Icon(icon, color: color, size: 24),
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
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
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

class _TrainingTab extends StatelessWidget {
  const _TrainingTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Training progress overview
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.school,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Training Progress',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _TrainingStatsCard(
                          title: 'Completed',
                          count: 8,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _TrainingStatsCard(
                          title: 'In Progress',
                          count: 3,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _TrainingStatsCard(
                          title: 'Recommended',
                          count: 5,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          const Text(
            'Available Training Courses',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Training courses
          _buildCourseCard(
            title: 'First Aid & CPR Certification',
            description: 'Learn essential life-saving techniques',
            duration: '4 hours',
            level: 'Beginner',
            progress: 0.0,
            isRecommended: true,
          ),
          
          _buildCourseCard(
            title: 'Fire Safety and Prevention',
            description: 'Understand fire hazards and prevention methods',
            duration: '2 hours',
            level: 'Beginner',
            progress: 0.6,
            isRecommended: false,
          ),
          
          _buildCourseCard(
            title: 'Emergency Response Coordination',
            description: 'Advanced emergency response management',
            duration: '6 hours',
            level: 'Advanced',
            progress: 1.0,
            isRecommended: false,
          ),
          
          _buildCourseCard(
            title: 'Natural Disaster Preparedness',
            description: 'Prepare for earthquakes, floods, and storms',
            duration: '3 hours',
            level: 'Intermediate',
            progress: 0.0,
            isRecommended: true,
          ),
        ],
      ),
    );
  }
  
  Widget _buildCourseCard({
    required String title,
    required String description,
    required String duration,
    required String level,
    required double progress,
    required bool isRecommended,
  }) {
    Color levelColor;
    switch (level) {
      case 'Beginner':
        levelColor = Colors.green;
        break;
      case 'Intermediate':
        levelColor = Colors.orange;
        break;
      case 'Advanced':
        levelColor = Colors.red;
        break;
      default:
        levelColor = Colors.grey;
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isRecommended)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Recommended',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.amber,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: levelColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    level,
                    style: TextStyle(
                      fontSize: 10,
                      color: levelColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  duration,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Spacer(),
                if (progress > 0)
                  Text(
                    '${(progress * 100).toInt()}% complete',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
            if (progress > 0) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  progress == 1.0 ? Colors.green : Theme.of(context).primaryColor,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (progress == 0)
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Start course
                    },
                    child: const Text('Start Course'),
                  )
                else if (progress < 1.0)
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Continue course
                    },
                    child: const Text('Continue'),
                  )
                else
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 20),
                      const SizedBox(width: 4),
                      const Text(
                        'Completed',
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TrainingStatsCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  
  const _TrainingStatsCard({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}