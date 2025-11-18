import 'package:flutter/material.dart';
import 'package:noise_guard_app/core/theme/app_colors.dart';

// Um widget placeholder para a imagem do mapa
class SensorMapImage extends StatelessWidget {
  const SensorMapImage({super.key});

  // Simula um ícone de sensor no mapa
  Widget _buildSensorIcon(
      {required double top,
      required double left,
      required Color color,
      required String id}) {
    return Positioned(
      top: top,
      left: left,
      child: Tooltip(
        message: 'Sensor $id',
        child: Icon(
          Icons.circle,
          color: color.withOpacity(0.8),
          size: 16,
        ),
      ),
    );
  }

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
            Text(
              'Planta Baixa - Shopping Flamboyant',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            // Placeholder para a imagem da planta
            Container(
              height: 500, // Altura fixa para o mapa
              width: double.infinity,
              decoration: BoxDecoration(
                color: DashboardColors.background,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  // Imagem de placeholder de uma planta baixa
                  image: NetworkImage('https://placehold.co/800x600/f0f4f8/ccc?text=Planta+Baixa'),
                  fit: BoxFit.cover,
                  opacity: 0.5,
                ),
              ),
              child: Stack(
                children: [
                  // Posições simuladas dos sensores
                  _buildSensorIcon(top: 100, left: 150, color: DashboardColors.lineRed, id: 'S-01 (Praça)'),
                  _buildSensorIcon(top: 400, left: 200, color: DashboardColors.lineBlue, id: 'S-02 (Entrada)'),
                  _buildSensorIcon(top: 250, left: 300, color: DashboardColors.green, id: 'S-03 (Corredor)'),
                  _buildSensorIcon(top: 120, left: 450, color: DashboardColors.green, id: 'S-04 (Loja A)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
