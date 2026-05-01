// lib/features/dashboard/widgets/stats_row.dart

import 'package:flutter/material.dart';
import 'package:noise_guard_app/common_widgets/stat_card.dart';
import 'package:noise_guard_app/core/theme/app_colors.dart';

class StatsRow extends StatelessWidget {
  final double averageNoiseLevel;
  final double peakNoiseLevel;

  const StatsRow({super.key, required this.averageNoiseLevel, required this.peakNoiseLevel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: StatCard(
            title: 'Sensores Ativos',
            value: '1',
            subtitle: '↑ Todos online',
            subtitleColor: DashboardColors.green,
            icon: Icons.sensors,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: StatCard(
            title: 'Nível Médio',
            value: '${averageNoiseLevel.toStringAsFixed(1)} dB',
            subtitle: '↑+2.1 de ontem', // (Estático por enquanto)
            subtitleColor: DashboardColors.green,
            icon: Icons.graphic_eq,
          ),
        ),
        // ------------------------------------------
        const SizedBox(width: 20),
        Expanded(
          child: StatCard(
            title: 'Pico Hoje',
            value: '${peakNoiseLevel.toStringAsFixed(1)} dB', 
            subtitle: '▲ Praça alimentação - 12:45',
            subtitleColor: DashboardColors.red,
            icon: Icons.arrow_upward,
          ),
        ),
        const SizedBox(width: 20),
        const Expanded(
          child: StatCard(
            title: 'Violações',
            value: '0', // (Estático por enquanto)
            subtitle: '↓ -2 de ontem',
            subtitleColor: DashboardColors.green,
            icon: Icons.warning_amber_rounded,
          ),
        ),
      ],
    );
  }
}
