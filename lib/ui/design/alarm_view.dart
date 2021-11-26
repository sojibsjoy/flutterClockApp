import 'package:clock_bloc/constants/colors.dart';
import 'package:clock_bloc/state_management/models/alarm_model.dart';
import 'package:clock_bloc/state_management/services/boxes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmView extends StatefulWidget {
  final List<Alarm> alarmList;

  const AlarmView({Key? key, required this.alarmList}) : super(key: key);

  @override
  _AlarmViewState createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  @override
  Widget build(BuildContext context) {
    if (widget.alarmList.isEmpty) {
      return Center(
        child: Text(
          "No alarms yet!",
          style: TextStyle(
            color: CustomColors.primaryTextColor,
            fontSize: 24,
          ),
        ),
      );
    } else {
      // Expanded to handle error that caused by parent Column
      return Expanded(
        child: ListView(
          children: widget.alarmList.map<Widget>((alarm) {
            return buildAlarm(context, alarm);
          }).followedBy([
            if (widget.alarmList.length < 5)
              DottedBorder(
                strokeWidth: 2,
                color: CustomColors.clockOutline,
                borderType: BorderType.RRect,
                radius: const Radius.circular(24),
                dashPattern: const [5, 4],
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: CustomColors.clockBG,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24),
                    ),
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ),
                    onPressed: () {
                      // NotificationAPI.showNotification(
                      //   title: "Office",
                      //   body: "Wake Up! Time for Office!",
                      //   payload: 'sarah.abs',
                      // );
                      // DateTime scheduleAlarmDateTime;
                      // if (_alarmTime!.isAfter(DateTime.now())) {
                      //   scheduleAlarmDateTime = _alarmTime!;
                      // } else {
                      //   scheduleAlarmDateTime =
                      //       _alarmTime!.add(const Duration(days: 1));
                      // }
                      // var alarmInfo = AlarmInfo(
                      //   title: "alarm",
                      //   alarmDateTime: scheduleAlarmDateTime,
                      //   gradientColorIndex: alarms.length,
                      // );
                      addAlarm();
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/add_alarm.png',
                          scale: 1.5,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Add Alarm',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'avenir',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              const Text('Only 2 alarm allowed'),
          ]).toList(),
        ),
      );
    }
  }

  Widget buildAlarm(BuildContext context, Alarm alarm) {
    final date = DateFormat.yMMMd().format(alarm.createdAt);
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.red],
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
                    size: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    alarm.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'avenir',
                    ),
                  ),
                ],
              ),
              Switch(
                value: alarm.isActive,
                onChanged: (bool value) {},
                activeColor: Colors.white,
              ),
            ],
          ),
          const Text(
            'Mon-Fri',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'avenir',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'avenir',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 36,
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }

  void addAlarm() {
    final alarm = Alarm()
      ..title = "Singing"
      ..description = "Be prepared! Enjoy the Evening."
      ..createdAt = DateTime.now()
      ..isActive = true;

    final box = Boxes.getAlarms();
    box.add(alarm);
  }
}
