import 'package:freeflow/helpers/environment.dart';

abstract class EnvConfig {
  Environment environment = Environment.Staging;

  String githash = "71d8b80";
  String time = "11:53:16 22.09.2022";
}