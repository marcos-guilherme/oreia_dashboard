import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// Importe o FlSpot do fl_chart
import 'package:fl_chart/fl_chart.dart'; 
import 'sensor_repository.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final SensorRepository _sensorRepository;
  StreamSubscription? _sensorSubscription;

  // --- Nossas variáveis de estado interno ---
  List<FlSpot> _noiseHistory = [];
  int _xCounter = 0;
  final int _maxHistorySize = 20; // Quantos pontos mostrar no gráfico
  // ------------------------------------------

  SensorBloc({required SensorRepository sensorRepository})
      : _sensorRepository = sensorRepository,
        super(SensorInitial()) {
    
    on<SensorStreamStarted>(_onStreamStarted);
    on<_SensorDataReceived>(_onDataReceived);
  }

  void _onStreamStarted(SensorStreamStarted event, Emitter<SensorState> emit) {
    _sensorSubscription?.cancel();
    
    // Reseta o histórico quando o stream (re)inicia
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
    
    // Emite o novo estado com o nível atual E a lista de histórico
    // É importante criar uma NOVA lista (List.from) para que o BLoC
    // e o BlocBuilder detectem a mudança de estado.
    emit(SensorDataUpdated(newNoiseLevel, List.from(_noiseHistory)));
  }

  @override
  Future<void> close() {
    _sensorSubscription?.cancel();
    return super.close();
  }
}