import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(dioProvider));
});

class AuthRepository {
  final Dio _dio;
  final _storage = const FlutterSecureStorage();

  AuthRepository(this._dio);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'username': email,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      
      final token = response.data['access_token'];
      final role = response.data['role']; // Ensure backend returns role in login or fetch user profile

      await _storage.write(key: 'jwt', value: token);
      
      // Update Dio headers for future requests
      _dio.options.headers['Authorization'] = 'Bearer $token';

      return {
        'success': true,
        'role': role ?? 'DOCTOR', // Fallback
      };
    } catch (e) {
      String message = 'Login failed';
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          message = 'Invalid email or password';
        } else {
          message = e.response?.data['detail'] ?? 'Connection error';
        }
      }
      return {
        'success': false,
        'message': message,
      };
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt');
    _dio.options.headers.remove('Authorization');
  }
}
