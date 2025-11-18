import 'dart:async';
import 'dart:math';

abstract class SensorRepository {
  Stream<double> getNoiseLevelStream();
}

class EmulatedSensorRepository implements SensorRepository {
  @override
  Stream<double> getNoiseLevelStream() {
    return Stream.periodic(Duration(seconds: 1), (count) {
      return 40.0 + (Random().nextDouble() * 20.0);
    });
  }
}
