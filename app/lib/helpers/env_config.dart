import 'package:freeflow/helpers/environment.dart';

abstract class EnvConfig {
  Environment environment = Environment.Staging;

  String githash = "c84daea";
  String time = "16:45:16 20.09.2022";
}