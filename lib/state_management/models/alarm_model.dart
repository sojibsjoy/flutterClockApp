import 'package:hive/hive.dart';

part 'alarm_model.g.dart';

@HiveType(typeId: 0)
class Alarm extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late bool isActive;

  @HiveField(3)
  late DateTime alarmTime;

  @HiveField(4)
  late List<String> alarmDays;
}
