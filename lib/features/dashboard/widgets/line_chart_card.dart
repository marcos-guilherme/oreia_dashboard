// lib/features/dashboard/widgets/line_chart_card.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:noise_guard_app/core/theme/app_colors.dart';

// -- WIDGET DO GRÁFICO DE LINHA --
class LineChartCard extends StatelessWidget {
  // --- ALTERAÇÃO PRINCIPAL: Recebe o histórico de dados ---
  final List<FlSpot> noiseHistory;

  const LineChartCard({
    super.key,
    required this.noiseHistory,
  });
  // ----------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: DashboardColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho do Gráfico (pode continuar estático)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Níveis de Ruído em Tempo Real',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Monitoramento ao vivo',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: DashboardColors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Ao Vivo',
                      style: TextStyle(
                          color: DashboardColors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // --- ALTERAÇÃO PRINCIPAL: Passa os dados para o gráfico ---
            SizedBox(
              height: 300,
              child: _NoiseLineChart(spots: noiseHistory),
            ),
            // --------------------------------------------------------
            const SizedBox(height: 16),
            // --- Legenda (simplificada para 1 sensor) ---
            const _ChartLegend(),
          ],
        ),
      ),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  const _ChartLegend();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendItem(
          color: DashboardColors.lineRed,
          text: 'Sensor 1 (Praça de Alimentação)',
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _NoiseLineChart extends StatelessWidget {
  // --- ALTERAÇÃO PRINCIPAL: Recebe os pontos ---
  final List<FlSpot> spots;

  const _NoiseLineChart({required this.spots});
  // -------------------------------------------

  @override
  Widget build(BuildContext context) {
    // --- Verificação de segurança para lista vazia ---
    if (spots.isEmpty) {
      return const Center(
        child: Text('Aguardando dados do sensor...'),
      );
    }
    // -------------------------------------------

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 10,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: DashboardColors.gaugeBackground,
              strokeWidth: 1,
            );
          },
        ),
        // Linha de limite (ex: 75 dB)
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: 75,
              color: DashboardColors.red.withOpacity(0.8),
              strokeWidth: 2,
              dashArray: [5, 5],
            ),
          ],
        ),
        titlesData: FlTitlesData(
          // --- Eixo X (inferior) dinâmico ---
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5, // Mostra um label a cada 5 pontos
              reservedSize: 30, // Espaço para os labels
              getTitlesWidget: (value, meta) {
                // Não mostra labels fora do range
                if (value < spots.first.x || value > spots.last.x) {
                  return Container();
                }
                // Mostra o label do eixo X (o "tempo")
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 8.0,
                  child: Text(
                    value.toInt().toString(), // Mostra o "contador"
                    style: const TextStyle(
                      color: DashboardColors.subText,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
          // --- Eixo Y (esquerda) ---
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 10, // Mostra de 10 em 10 (30, 40, 50...)
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value % 10 == 0 && value >= 30 && value <= 90) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                        color: DashboardColors.subText, fontSize: 10),
                    textAlign: TextAlign.right,
                  );
                }
                return Container();
              },
            ),
          ),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(color: DashboardColors.gaugeBackground, width: 1),
            left: BorderSide(color: DashboardColors.gaugeBackground, width: 1),
          ),
        ),
        // --- Limites dinâmicos ---
        minX: spots.first.x, // O X do primeiro item da lista
        maxX: spots.last.x, // O X do último item da lista
        minY: 30, // Valor fixo abaixo do mínimo esperado
        maxY: 90, // Valor fixo acima do máximo esperado
        // -------------------------
        lineBarsData: [
          // --- USA OS DADOS REAIS ---
          _buildLineChartBarData(spots, DashboardColors.lineRed),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (LineBarSpot touchedSpot) {
              return Colors.blueGrey.withOpacity(0.8);
            },
          ),
        ),
      ),
    );
  }

  // Helper para criar uma barra de dados do gráfico de linha
  LineChartBarData _buildLineChartBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
          radius: 4,
          color: color,
          strokeWidth: 1,
          strokeColor: Colors.white,
        ),
      ),
      belowBarData: BarAreaData(show: false),
    );
  }
}