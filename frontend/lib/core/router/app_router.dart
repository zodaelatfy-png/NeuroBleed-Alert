import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/home/presentation/doctor_dashboard.dart';
import '../../features/home/presentation/main_layout.dart';
import '../../features/admin/presentation/admin_dashboard.dart';
import '../../features/emergency/presentation/hospital_map_screen.dart';

// Providers for Auth State
final authStateProvider = StateProvider<bool>((ref) => false);
final userRoleProvider = StateProvider<String?>((ref) => null); // 'USER', 'DOCTOR', 'SUPER_ADMIN'

final routerProvider = Provider<GoRouter>((ref) {
  final isAuth = ref.watch(authStateProvider);
  final role = ref.watch(userRoleProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      
      if (!isAuth && !isLoggingIn) return '/login';
      
      if (isAuth && isLoggingIn) {
        if (role == 'SUPER_ADMIN') {
          return '/_sys_admin_panel_secure';
        } else if (role == 'DOCTOR') {
          return '/doctor_dashboard';
        } else {
          return '/home';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainLayout(),
      ),
      GoRoute(
        path: '/doctor_dashboard',
        builder: (context, state) => const DoctorDashboard(),
      ),
      GoRoute(
        path: '/_sys_admin_panel_secure',
        builder: (context, state) {
          if (role != 'SUPER_ADMIN') {
            return const Scaffold(body: Center(child: Text('Unauthorized')));
          }
          return const AdminDashboard();
        },
      ),
    ],
  );
});
