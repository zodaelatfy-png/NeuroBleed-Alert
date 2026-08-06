import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/neuro_theme.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: NeuroBleedApp(),
    ),
  );
}

class NeuroBleedApp extends ConsumerWidget {
  const NeuroBleedApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'NeuroBleed Alert',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: NeuroTheme.darkTheme,
      routerConfig: router,
    );
  }
}
