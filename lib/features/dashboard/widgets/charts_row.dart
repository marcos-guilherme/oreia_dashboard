// lib/features/dashboard/widgets/charts_row.dart

import 'package:fl_chart/fl_chart.dart'; // <-- ADICIONADO para FlSpot
import 'package:flutter/material.dart';
import 'package:noise_guard_app/features/dashboard/widgets/gauge_card.dart';
import 'package:noise_guard_app/features/dashboard/widgets/line_chart_card.dart';

class ChartsRow extends StatelessWidget {
  final double currentNoiseLevel;
  final List<FlSpot> noiseHistory;

  const ChartsRow({
    super.key,
    required this.currentNoiseLevel,
    required this.noiseHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: LineChartCard(
            noiseHistory: noiseHistory,
          ),
        ),
        // --------------------------------------------
        const SizedBox(width: 20),
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