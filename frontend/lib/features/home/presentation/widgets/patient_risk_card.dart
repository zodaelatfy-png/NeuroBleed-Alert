import 'package:flutter/material.dart';
import '../../../../core/theme/neuro_colors.dart';
import '../../../../core/theme/neuro_typography.dart';

class PatientRiskCard extends StatelessWidget {
  final String patientName;
  final String id;
  final String riskLevel; // HIGH, MEDIUM, LOW
  final VoidCallback onTap;

  const PatientRiskCard({
    super.key,
    required this.patientName,
    required this.id,
    required this.riskLevel,
    required this.onTap,
  });

  Color _getRiskColor() {
    switch (riskLevel.toUpperCase()) {
      case 'HIGH':
        return NeuroColors.brainRiskHigh;
      case 'MEDIUM':
        return NeuroColors.brainRiskMedium;
      case 'LOW':
        return NeuroColors.brainRiskLow;
      default:
        return NeuroColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: _getRiskColor().withOpacity(0.2),
          child: Icon(Icons.person, color: _getRiskColor()),
        ),
        title: Text(patientName, style: NeuroTypography.textTheme.titleLarge),
        subtitle: Text('ID: $id', style: NeuroTypography.textTheme.bodyMedium),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getRiskColor().withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _getRiskColor()),
          ),
          child: Text(
            riskLevel,
            style: TextStyle(
              color: _getRiskColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
