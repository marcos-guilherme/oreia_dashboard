import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart'; 
import 'sensor_repository.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final SensorRepository _sensorRepository;
  StreamSubscription? _sensorSubscription;

  List<FlSpot> _noiseHistory = [];
  int _xCounter = 0;
  final int _maxHistorySize = 20; 

  SensorBloc({required SensorRepository sensorRepository})
      : _sensorRepository = sensorRepository,
        super(SensorInitial()) {
    
    on<SensorStreamStarted>(_onStreamStarted);
    on<_SensorDataReceived>(_onDataReceived);
  }

  void _onStreamStarted(SensorStreamStarted event, Emitter<SensorState> emit) {
    _sensorSubscription?.cancel();
    
    _noiseHistory = [];
    _xCounter = 0;
    emit(SensorInitial()); // Emite o estado inicial para mostrar "loading"

    _sensorSubscription = _sensorRepository.getNoiseLevelStream().listen(
      (data) {
        add(_SensorDataReceived(data));
      },
      onError: (error) {
        emit(SensorError(error.toString()));
      },
    );
  }

  void _onDataReceived(_SensorDataReceived event, Emitter<SensorState> emit) {
    final double newNoiseLevel = event.data;
    
    // Cria um novo ponto para o gráfico
    final newSpot = FlSpot(_xCounter.toDouble(), newNoiseLevel);
    
    // Adiciona o novo ponto à nossa lista interna
    _noiseHistory.add(newSpot);

    // Se a lista for muito grande, remove o item mais antigo (do início)
    if (_noiseHistory.length > _maxHistorySize) {
      _noiseHistory.removeAt(0);
    }
    
    // Incrementa o nosso eixo X
    _xCounter++;
    
    emit(SensorDataUpdated(newNoiseLevel, List.from(_noiseHistory)));
  }

  @override
  Future<void> close() {
    _sensorSubscription?.cancel();
    return super.close();
  }
}