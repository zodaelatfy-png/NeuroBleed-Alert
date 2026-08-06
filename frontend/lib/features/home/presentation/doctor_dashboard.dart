import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/neuro_colors.dart';
import '../../../../core/theme/neuro_typography.dart';
import 'widgets/patient_risk_card.dart';
import '../data/ai_provider.dart';

class DoctorDashboard extends ConsumerStatefulWidget {
  const DoctorDashboard({super.key});

  @override
  ConsumerState<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends ConsumerState<DoctorDashboard> {
  @override
  Widget build(BuildContext context) {
    final patientsAsync = ref.watch(patientsAIProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Clinical Dashboard', style: NeuroTypography.textTheme.headlineLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: NeuroColors.emergency),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(patientsAIProvider);
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
                boxShadow: [
                  BoxShadow(color: NeuroColors.primary.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5)),
                ],
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
                    'Monitoring 24 active ESP32 Bluetooth sensors. API connected.',
                    style: NeuroTypography.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            Text('Active Patients (Live AI Predictions)', style: NeuroTypography.textTheme.titleLarge),
            const SizedBox(height: 12),

            patientsAsync.when(
              data: (patients) {
                return Column(
                  children: patients.map((p) {
                    return PatientRiskCard(
                      patientName: p['name'],
                      id: p['id'],
                      riskLevel: p['ai_analysis']['risk_level'] ?? 'UNKNOWN',
                      onTap: () {},
                    );
                  }).toList(),
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(32.0),
                child: Center(child: CircularProgressIndicator(color: NeuroColors.primary)),
              ),
              error: (err, stack) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Error loading AI data: $err', style: const TextStyle(color: NeuroColors.emergency)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: NeuroColors.primary,
        onPressed: () {
          ref.invalidate(patientsAIProvider);
        },
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}

