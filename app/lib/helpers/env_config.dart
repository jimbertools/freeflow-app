import 'package:freeflow/helpers/environment.dart';

abstract class EnvConfig {
  Environment environment = Environment.Staging;

  String githash = "bb8c4f7";
  String time = "16:21:18 20.09.2022";
}