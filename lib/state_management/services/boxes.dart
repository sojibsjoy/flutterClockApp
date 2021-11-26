import 'package:clock_bloc/state_management/models/alarm_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Alarm> getAlarms() => Hive.box<Alarm>('alarms');
}
