// lib/features/dashboard/widgets/main_content.dart

import 'package:fl_chart/fl_chart.dart'; // <-- ADICIONADO para FlSpot
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noise_guard_app/bloc/sensor_bloc.dart';
import 'package:noise_guard_app/features/dashboard/widgets/charts_row.dart';
import 'package:noise_guard_app/features/dashboard/widgets/stats_row.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    // --- ALTERAÇÃO PRINCIPAL: O layout é envolvido por um BlocBuilder ---
    return BlocBuilder<SensorBloc, SensorState>(
      builder: (context, state) {
        // Extrai os dados do estado, com valores padrão
        double currentNoiseLevel = 0.0;
        List<FlSpot> currentHistory = [];

        if (state is SensorDataUpdated) {
          currentNoiseLevel = state.noiseLevel;
          currentHistory = state.noiseHistory;
        }

        // Usamos um SingleChildScrollView para evitar overflow em telas menores
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Título Estático ---
              Text(
                'Visão Geral do Painel',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),

              // --- Conteúdo Dinâmico (depende do estado) ---

              // Estado de Carregamento
              if (state is SensorInitial)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Conectando aos sensores...'),
                      ],
                    ),
                  ),
                ),

              // Estado de Erro
              if (state is SensorError)
                Center(
                  child: Text(
                    'Erro no sensor: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              // Estado de Sucesso (Temos dados!)
              if (state is SensorDataUpdated)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Passa o dado atual para o StatsRow
                    StatsRow(
                      currentNoiseLevel: currentNoiseLevel,
                    ),
                    const SizedBox(height: 20),
                    // 2. Passa o dado atual e o histórico para o ChartsRow
                    ChartsRow(
                      currentNoiseLevel: currentNoiseLevel,
                      noiseHistory: currentHistory,
                    ),
                    const SizedBox(height: 20),
                    // (Aqui você pode adicionar mais widgets estáticos,
                    // como uma tabela de logs ou alertas recentes)
                  ],
                ),
            ],
          ),
        );
      },
    );
    // ------------------------------------------------------------------
  }
}