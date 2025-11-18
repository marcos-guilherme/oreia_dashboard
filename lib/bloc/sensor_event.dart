part of 'sensor_bloc.dart';

abstract class SensorEvent extends Equatable {
  const SensorEvent();
  @override
  List<Object> get props => [];
}

// Evento que a UI vai disparar para o Bloc começar a escutar o repositório
class SensorStreamStarted extends SensorEvent {}

// Evento interno que o Bloc usa para processar novos dados
class _SensorDataReceived extends SensorEvent {
  final double data;
  const _SensorDataReceived(this.data);
  @override
  List<Object> get props => [data];
}