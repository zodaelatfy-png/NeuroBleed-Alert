import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ai_repository.dart';

// Dummy patient data for demonstration
final List<Map<String, dynamic>> dummyPatients = [
  {
    "id": "PT-8943",
    "name": "Ahmed Mahmoud",
    "vitals": {
      "systolic_bp": 160,
      "diastolic_bp": 100,
      "heart_rate": 95,
      "age": 65,
      "gender": "male",
      "blood_oxygen": 92
    }
  },
  {
    "id": "PT-1022",
    "name": "Sarah Jenkins",
    "vitals": {
      "systolic_bp": 120,
      "diastolic_bp": 80,
      "heart_rate": 72,
      "age": 45,
      "gender": "female",
      "blood_oxygen": 98
    }
  }
];

final patientsAIProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final aiRepo = ref.watch(aiRepositoryProvider);
  final List<Map<String, dynamic>> results = [];

  for (var patient in dummyPatients) {
    final aiResult = await aiRepo.analyzeRisk(patient['vitals']);
    results.add({
      ...patient,
      "ai_analysis": aiResult ?? {"risk_level": "UNKNOWN", "risk_score": 0.0},
    });
  }

  return results;
});
