import 'package:flutter/material.dart';
import '../../../../core/theme/neuro_colors.dart';
import '../../../../core/theme/neuro_typography.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeuroColors.background,
      appBar: AppBar(
        title: Text('Enterprise Admin (Restricted)', 
            style: NeuroTypography.textTheme.headlineLarge?.copyWith(color: NeuroColors.emergency)),
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: NeuroColors.emergency.withOpacity(0.1),
                border: Border.all(color: NeuroColors.emergency, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.security, color: NeuroColors.emergency, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SUPER ADMIN CLEARANCE ACTIVE',
                            style: NeuroTypography.textTheme.titleLarge?.copyWith(
                                color: NeuroColors.emergency, fontWeight: FontWeight.bold)),
                        Text('Welcome, medomaree11. All system overrides are enabled.',
                            style: NeuroTypography.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('System Overview', style: NeuroTypography.textTheme.titleLarge),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildStatCard('Active Users', '12,492', Icons.people, NeuroColors.primary),
                  _buildStatCard('Live Sensors', '843', Icons.bluetooth, NeuroColors.secondary),
                  _buildStatCard('AI Inferences (24h)', '5,102', Icons.psychology, Colors.purpleAccent),
                  _buildStatCard('System Health', '99.9%', Icons.monitor_heart, NeuroColors.secondary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      color: NeuroColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(value, style: NeuroTypography.textTheme.displaySmall),
            const SizedBox(height: 4),
            Text(title, style: NeuroTypography.textTheme.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
