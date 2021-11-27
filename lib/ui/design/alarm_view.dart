import 'package:clock_bloc/constants/colors.dart';
import 'package:clock_bloc/state_management/models/alarm_model.dart';
import 'package:clock_bloc/ui/design/add_alarm.dart';
import 'package:clock_bloc/ui/design/alarm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class AlarmView extends StatefulWidget {
  final List<Alarm> alarmList;

  const AlarmView({Key? key, required this.alarmList}) : super(key: key);

  @override
  _AlarmViewState createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  bool isExpanded = false;
  int expandedKey = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.alarmList.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_alarm,
                    color: CustomColors.primaryTextColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "No alarms yet!",
                    style: TextStyle(
                      color: CustomColors.primaryTextColor,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const AddAlarmWidget(),
          ],
        ),
      );
    } else {
      // Expanded to handle error that caused by parent Column
      return TimerBuilder.periodic(
        const Duration(minutes: 1),
        builder: (context) {
          return Expanded(
            child: ListView(
              children: widget.alarmList.map<Widget>((alarm) {
                return buildAlarm(context, alarm);
              }).followedBy([
                if (widget.alarmList.length < 5)
                  const AddAlarmWidget()
                else
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.block,
                          color: CustomColors.primaryTextColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Only 5 alarms allowed!",
                          style: TextStyle(
                            color: CustomColors.primaryTextColor,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
              ]).toList(),
            ),
          );
        },
      );
    }
  }

  Widget buildAlarm(BuildContext context, Alarm alarm) {
    // final date = DateFormat.yMMMEd().format(alarm.alarmTime);
    final time = DateFormat("hh:mm a").format(alarm.alarmTime);
    final timeDelay = timeDifference(alarm.alarmTime);
    List<Color> bgColors;
    switch (alarm.key % 5) {
      case 1:
        bgColors = GradientColors.fire;
        break;
      case 2:
        bgColors = GradientColors.mango;
        break;
      case 3:
        bgColors = GradientColors.sea;
        break;
      case 4:
        bgColors = GradientColors.sky;
        break;
      case 0:
        bgColors = GradientColors.sunset;
        break;
      default:
        bgColors = GradientColors.sunset;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: bgColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 4,
            offset: const Offset(4, 4),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(
            24,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.label,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    alarm.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'avenir',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Switch(
                activeColor: Colors.cyan,
                activeTrackColor: Colors.cyanAccent,
                value: alarm.isActive,
                onChanged: (bool value) {
                  setState(() {
                    alarm.isActive = value;
                    alarm.save();
                  });
                },
              ),
            ],
          ),
          Text(
            alarm.description,
            style: TextStyle(
              color: CustomColors.primaryTextColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 25,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: alarm.alarmDays.map<Widget>((day) {
                return Text(
                  day + " ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'avenir',
                    fontSize: 15,
                  ),
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Active Time: " + time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'avenir',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Alarm in " + timeDelay,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'avenir',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    expandedKey = alarm.key;
                    isExpanded = !isExpanded;
                  });
                },
                child: Icon(
                  isExpanded && expandedKey == alarm.key
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 36,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 13,
          ),
          isExpanded && expandedKey == alarm.key
              ? Column(
                  children: [
                    const Divider(
                      color: Colors.white,
                      height: 1,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AlarmDialog(
                                alarm: alarm,
                                onClickedDone: (title, description, isActive,
                                        alarmTime, alarmDays) =>
                                    editAlarm(alarm, title, description,
                                        isActive, alarmTime, alarmDays),
                              ),
                            ),
                            icon: Icon(
                              Icons.edit,
                              color: CustomColors.primaryTextColor,
                            ),
                            label: Text(
                              'Edit',
                              style: TextStyle(
                                color: CustomColors.primaryTextColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () {
                              setState(() {
                                isExpanded = false;
                                expandedKey = 0;
                                alarm.delete();
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: CustomColors.primaryTextColor,
                            ),
                            label: Text(
                              'Delete',
                              style: TextStyle(
                                color: CustomColors.primaryTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }

  void editAlarm(
    Alarm alarm,
    String title,
    String description,
    bool isActive,
    DateTime alarmTime,
    List<String> alarmDays,
  ) {
    alarm.title = title;
    alarm.description = description;
    alarm.isActive = isActive;
    alarm.alarmTime = alarmTime;
    alarm.alarmDays = alarmDays;

    alarm.save();
  }

  String timeDifference(DateTime alarmTime) {
    DateTime nowTime = DateTime.now();

    double _doubleYourTime =
        alarmTime.hour.toDouble() + (alarmTime.minute.toDouble() / 60);
    double _doubleNowTime =
        nowTime.hour.toDouble() + (nowTime.minute.toDouble() / 60);

    double _timeDiff = _doubleYourTime - _doubleNowTime;

    int _hr = _timeDiff.truncate();
    int _min = ((_timeDiff - _timeDiff.truncate()) * 60).toInt();
    if (_hr <= 0) {
      _hr = 23 + _hr;
      if (_min <= 0) {
        _min = 59 + _min;
      }
      if (_hr == 1) {
        if (_min == 1) {
          return '$_hr Hour $_min minute';
        } else {
          return '$_hr Hour $_min minutes';
        }
      } else {
        if (_min == 1) {
          return '$_hr Hours $_min minute';
        } else {
          return '$_hr Hours $_min minutes';
        }
      }
    } else {
      if (_min <= 0) {
        _min = 59 + _min;
      }
      if (_hr == 1) {
        if (_min == 1) {
          return '$_hr Hour $_min minute';
        } else {
          return '$_hr Hour $_min minutes';
        }
      } else {
        if (_min == 1) {
          return '$_hr Hours $_min minute';
        } else {
          return '$_hr Hours $_min minutes';
        }
      }
    }
  }
}
