import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';

final aiRepositoryProvider = Provider<AIRepository>((ref) {
  return AIRepository(ref.watch(dioProvider));
});

class AIRepository {
  final Dio _dio;
  AIRepository(this._dio);

  Future<Map<String, dynamic>?> analyzeRisk(Map<String, dynamic> patientData) async {
    try {
      final response = await _dio.post('/ai/analyze-risk', data: patientData);
      return response.data;
    } catch (e) {
      print('Error fetching AI risk: $e');
      return null;
    }
  }
}
