import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/neuro_colors.dart';
import '../../../../core/theme/neuro_typography.dart';
import 'widgets/patient_risk_card.dart';

class DoctorDashboard extends ConsumerStatefulWidget {
  const DoctorDashboard({super.key});

  @override
  ConsumerState<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends ConsumerState<DoctorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clinical Dashboard', style: NeuroTypography.textTheme.headlineLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: NeuroColors.emergency),
            onPressed: () {
              // Open Notifications
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh patients list
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // AI Summary Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [NeuroColors.primary, Color(0xFF1E3A8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.psychology, color: Colors.white, size: 32),
                      const SizedBox(width: 12),
                      Text('AI Risk Analysis Active', 
                        style: NeuroTypography.textTheme.titleLarge?.copyWith(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Monitoring 24 active ESP32 Bluetooth sensors. 1 critical alert detected in the last hour.',
                    style: NeuroTypography.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Section Title
            Text('Active Patients', style: NeuroTypography.textTheme.titleLarge),
            const SizedBox(height: 12),

            // Patient List (Mock Data)
            PatientRiskCard(
              patientName: 'Ahmed Mahmoud',
              id: 'PT-8943',
              riskLevel: 'HIGH',
              onTap: () {}, // Navigate to Patient Details / Reports
            ),
            PatientRiskCard(
              patientName: 'Sarah Jenkins',
              id: 'PT-1022',
              riskLevel: 'MEDIUM',
              onTap: () {},
            ),
            PatientRiskCard(
              patientName: 'Ziad Tariq',
              id: 'PT-9931',
              riskLevel: 'LOW',
              onTap: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: NeuroColors.primary,
        onPressed: () {
          // Add new patient or connect new Bluetooth device
        },
        child: const Icon(Icons.bluetooth_connected, color: Colors.white),
      ),
    );
  }
}
