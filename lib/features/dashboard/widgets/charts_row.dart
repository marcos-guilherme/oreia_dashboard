// lib/features/dashboard/widgets/charts_row.dart

import 'package:fl_chart/fl_chart.dart'; // <-- ADICIONADO para FlSpot
import 'package:flutter/material.dart';
import 'package:noise_guard_app/features/dashboard/widgets/gauge_card.dart';
import 'package:noise_guard_app/features/dashboard/widgets/line_chart_card.dart';

class ChartsRow extends StatelessWidget {
  // --- ALTERAÇÃO PRINCIPAL: Recebe ambos os dados ---
  final double currentNoiseLevel;
  final List<FlSpot> noiseHistory;

  const ChartsRow({
    super.key,
    required this.currentNoiseLevel,
    required this.noiseHistory,
  });
  // ------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // A Row não pode ser 'const' pois seus filhos são dinâmicos
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- ALTERAÇÃO PRINCIPAL: Passa o histórico ---
        Expanded(
          flex: 3,
          child: LineChartCard(
            noiseHistory: noiseHistory,
          ),
        ),
        // --------------------------------------------
        const SizedBox(width: 20),
        // --- ALTERAÇÃO PRINCIPAL: Passa o valor atual ---
        Expanded(
          flex: 1,
          child: GaugeCard(
            currentValue: currentNoiseLevel,
          ),
        ),
        // --------------------------------------------
      ],
    );
  }
}