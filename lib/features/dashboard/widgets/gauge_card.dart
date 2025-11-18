// lib/features/dashboard/widgets/gauge_card.dart

import 'package:flutter/material.dart';
import 'package:noise_guard_app/common_widgets/gauge_widget.dart';
import 'package:noise_guard_app/core/theme/app_colors.dart';

class GaugeCard extends StatelessWidget {
  // --- ALTERAÇÃO PRINCIPAL: Recebe o dado ---
  final double currentValue;

  const GaugeCard({
    super.key,
    required this.currentValue,
  });
  // ------------------------------------------

  @override
  Widget build(BuildContext context) {
    const double maxValue = 100.0; // O máximo do medidor

    // --- Lógica dinâmica para cor e texto ---
    String statusText;
    Color valueColor;
    if (currentValue > 75) {
      statusText = 'Nível Crítico';
      valueColor = DashboardColors.lineRed;
    } else if (currentValue > 60) {
      statusText = 'Nível Elevado';
      valueColor = Colors.orange; // Cor intermediária
    } else {
      statusText = 'Nível Normal';
      valueColor = DashboardColors.green;
    }
    // ------------------------------------------

    return Card(
      elevation: 2,
      color: DashboardColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Nível Atual',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 220, // Altura fixa para o medidor
              // --- ALTERAÇÃO PRINCIPAL: Passa o valor para o GaugeWidget ---
              child: GaugeWidget(
                value: currentValue,
                maxValue: maxValue,
                // Você pode até passar a cor dinâmica, se o GaugeWidget suportar
                valueColor: valueColor, 
              ),
            ),
            const SizedBox(height: 16),
            // --- Texto do valor dinâmico ---
            Text(
              '${currentValue.toStringAsFixed(1)}dB',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 26, color: valueColor),
            ),
            const SizedBox(height: 4),
            // --- Texto de status dinâmico ---
            Text(
              statusText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: valueColor),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}