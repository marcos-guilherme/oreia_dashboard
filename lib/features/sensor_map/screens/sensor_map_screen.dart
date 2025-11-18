import 'package:flutter/material.dart';
import 'package:noise_guard_app/common_widgets/stat_card.dart';
import 'package:noise_guard_app/core/theme/app_colors.dart';
import 'package:noise_guard_app/features/sensor_map/widgets/sensor_list_table.dart';
import 'package:noise_guard_app/features/sensor_map/widgets/sensor_map_image.dart';

class SensorMapScreen extends StatelessWidget {
  const SensorMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Cabeçalho
          Text(
            'Mapa de Sensores',
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 8),
          Text(
            'Visualização em tempo real dos sensores no local',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // 2. Linha de Estatísticas (reutilizando StatCard)
          // CORREÇÃO: Adicionado 'const' aos children (StatCard e SizedBox)
          // para que o 'const Row' seja válido.
          const Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Total de Sensores',
                  value: '24',
                  subtitle: '',
                  subtitleColor: DashboardColors.subText,
                  icon: Icons.sensors,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: StatCard(
                  title: 'Sensores Online',
                  value: '24',
                  subtitle: '100% online',
                  subtitleColor: DashboardColors.green,
                  icon: Icons.wifi,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: StatCard(
                  title: 'Sensores Offline',
                  value: '0',
                  subtitle: 'Nenhum sensor offline',
                  subtitleColor: DashboardColors.subText,
                  icon: Icons.wifi_off,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 3. Conteúdo da Página (Mapa e Lista)
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coluna da Esquerda (Mapa)
              Expanded(
                flex: 2,
                child: SensorMapImage(), // Widget do placeholder do mapa
              ),
              SizedBox(width: 20),
              // Coluna da Direita (Lista)
              Expanded(
                flex: 1,
                child: SensorListTable(), // Widget da tabela de sensores
              ),
            ],
          )
        ],
      ),
    );
  }
}

