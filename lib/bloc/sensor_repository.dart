import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:web_socket_channel/web_socket_channel.dart';

abstract class SensorRepository {
  Stream<double> getNoiseLevelStream();
}

class EmulatedSensorRepository implements SensorRepository {
  @override
  Stream<double> getNoiseLevelStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) {
      return 40.0 + (Random().nextDouble() * 20.0);
    });
  }
}

class ApiSensorRepository implements SensorRepository {
  final String wsUrl;

  ApiSensorRepository({this.wsUrl = 'ws://localhost:8080/ws/noise'});

  @override
  Stream<double> getNoiseLevelStream() => _wsStream();

  Stream<double> _wsStream() async* {
    while (true) {
      try {
        final channel = WebSocketChannel.connect(Uri.parse(wsUrl));
        await for (final raw in channel.stream) {
          final data = json.decode(raw as String) as Map<String, dynamic>;
          if (data['type'] == 'history') {
            for (final r in (data['readings'] as List)) {
              final db = (r['db'] as num?)?.toDouble();
              if (db != null) yield db;
            }
          } else if (data['type'] != 'ping') {
            final db = (data['db'] as num?)?.toDouble();
            if (db != null) yield db;
          }
        }
      } catch (_) {
        await Future.delayed(const Duration(seconds: 3));
      }
    }
  }
}
