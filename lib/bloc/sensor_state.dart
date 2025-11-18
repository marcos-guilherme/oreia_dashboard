part of 'sensor_bloc.dart';

abstract class SensorState extends Equatable {
  const SensorState();
  @override
  List<Object> get props => [];
}

// Estado inicial, nada aconteceu ainda
class SensorInitial extends SensorState {}

// O estado principal: temos dados! A UI vai reagir a este estado.
class SensorDataUpdated extends SensorState {
  final double noiseLevel;
  final List<FlSpot> noiseHistory;

  const SensorDataUpdated(this.noiseLevel, this.noiseHistory);

  @override
  List<Object> get props => [noiseLevel, noiseHistory];
}

// Estado de erro, caso o stream falhe
class SensorError extends SensorState {
  final String message;
  const SensorError(this.message);
  @override
  List<Object> get props => [message];
}
