// lib/features/dashboard/widgets/stats_row.dart

import 'package:flutter/material.dart';
import 'package:noise_guard_app/common_widgets/stat_card.dart';
import 'package:noise_guard_app/core/theme/app_colors.dart';

class StatsRow extends StatelessWidget {
  final double currentNoiseLevel;

  const StatsRow({
    super.key,
    required this.currentNoiseLevel,O
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: StatCard(
            title: 'Sensores Ativos',
            value: '24', // (Dado estático por enquanto)
            subtitle: '↑ Todos online',
            subtitleColor: DashboardColors.green,
            icon: Icons.sensors,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: StatCard(
            title: 'Nível Médio', // ou "Nível Atual"
            value: '${currentNoiseLevel.toStringAsFixed(1)} dB', // <-- DADO REAL
            subtitle: '↑+2.1 de ontem', // (Estático por enquanto)
            subtitleColor: DashboardColors.green,
            icon: Icons.graphic_eq,
          ),
        ),
        // ------------------------------------------
        const SizedBox(width: 20),
        const Expanded(
          child: StatCard(
            title: 'Pico Hoje',
            value: '89.7 dB', // (Estático por enquanto)
            subtitle: '▲ Praça alimentação - 12:45',
            subtitleColor: DashboardColors.red,
            icon: Icons.arrow_upward,
          ),
        ),
        const SizedBox(width: 20),
        const Expanded(
          child: StatCard(
            title: 'Violações',
            value: '3', // (Estático por enquanto)
            subtitle: '↓ -2 de ontem',
            subtitleColor: DashboardColors.green,
            icon: Icons.warning_amber_rounded,
          ),
        ),
      ],
    );
  }
}