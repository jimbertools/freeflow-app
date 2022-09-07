import 'dart:async';
import 'package:sensors/sensors.dart';

Future<Map<String, dynamic>> getAccelleroValues() async {
  AccelerometerEvent? e;
  StreamSubscription? acc;

  acc = accelerometerEvents.listen((AccelerometerEvent event) {
    e = event;
    acc?.cancel();
  });

  await Future.delayed(new Duration(milliseconds: 300));

  return {
    "x" : e?.x,
    "y" : e?.y,
    "z" : e?.z
  };
}