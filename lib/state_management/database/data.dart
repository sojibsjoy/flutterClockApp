import 'package:clock_bloc/state_management/models/alarm_info.dart';
import 'package:clock_bloc/state_management/models/enums.dart';
import 'package:clock_bloc/state_management/models/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(
    MenuType.clock,
    title: 'Clock',
    imageSource: 'assets/images/clock_icon.png',
  ),
  MenuInfo(
    MenuType.alarm,
    title: 'Alarm',
    imageSource: 'assets/images/alarm_icon.png',
  ),
  MenuInfo(
    MenuType.timer,
    title: 'Timer',
    imageSource: 'assets/images/timer_icon.png',
  ),
  MenuInfo(
    MenuType.stopwatch,
    title: 'Stopwatch',
    imageSource: 'assets/images/stopwatch_icon.png',
  ),
];

List<AlarmInfo> alarms = [
  // AlarmInfo(DateTime.now().add(const Duration(hours: 1)),
  //     gradientColors: GradientColors.sky,
  //     title: "Office",
  //     description: "Wake Up!  Time for the Office."),
  // AlarmInfo(DateTime.now().add(const Duration(hours: 2)),
  //     gradientColors: GradientColors.sunset,
  //     title: "Sport",
  //     description: "Let's Play!!! Go, get ready quickly."),
];
