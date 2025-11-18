import 'package:flutter/material.dart';
import 'package:noise_guard_app/core/theme/app_colors.dart';
import 'package:noise_guard_app/features/dashboard/screens/dashboard_screen.dart';

// Este widget agora contém o MaterialApp,
// definindo o tema e a tela inicial.
class NoiseGuardApp extends StatelessWidget {
  const NoiseGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoiseGuard Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: DashboardColors.background,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              color: DashboardColors.darkText,
              fontWeight: FontWeight.bold,
              fontSize: 22),
          titleMedium: TextStyle(
              color: DashboardColors.darkText,
              fontWeight: FontWeight.bold,
              fontSize: 18),
          bodyMedium: TextStyle(color: DashboardColors.subText, fontSize: 14),
          bodySmall: TextStyle(color: DashboardColors.subText, fontSize: 12),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
    );
  }
}
