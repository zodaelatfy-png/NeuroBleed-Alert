import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/neuro_colors.dart';
import '../../core/theme/neuro_typography.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    // In real app, this calls the AuthRepository which calls the FastAPI endpoint.
    // For now, we simulate the redirection logic requested in the Master Prompt.
    final email = _emailController.text.trim();
    
    // Simulate API Response mapping
    // ref.read(authStateProvider.notifier).state = true;
    // ref.read(userRoleProvider.notifier).state = 'ROLE';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeuroColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo Area
                Icon(
                  Icons.psychology, 
                  size: 100, 
                  color: NeuroColors.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'NeuroBleed Alert',
                  textAlign: TextAlign.center,
                  style: NeuroTypography.textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'AI-Powered Early Detection System',
                  textAlign: TextAlign.center,
                  style: NeuroTypography.textTheme.bodyMedium,
                ),
                const SizedBox(height: 48),
                
                // Form Area
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined, color: NeuroColors.textSecondary),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline, color: NeuroColors.textSecondary),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Login Button
                ElevatedButton(
                  onPressed: _handleLogin,
                  child: const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                
                // Notice: No Role Selection dropdown as requested!
              ],
            ),
          ),
        ),
      ),
    );
  }
}
