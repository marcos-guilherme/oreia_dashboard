import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noise_guard_app/bloc/sensor_bloc.dart';
import 'package:noise_guard_app/bloc/sensor_repository.dart';
import 'package:noise_guard_app/features/dashboard/screens/dashboard_screen.dart';

// O ponto de entrada principal do aplicativo.
// Agora está limpo e apenas inicializa o app.
void main() {
  runApp(NoiseGuardApp());
}

class NoiseGuardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider<SensorRepository>(
        create: (context) => EmulatedSensorRepository(),
        child: BlocProvider<SensorBloc>(
          create: (context) =>
              SensorBloc(sensorRepository: context.read<SensorRepository>())
                ..add(SensorStreamStarted()),
          child: DashboardScreen(),
        ),
      ),
    );
  }
}
