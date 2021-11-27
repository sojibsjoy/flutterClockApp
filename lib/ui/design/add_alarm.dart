import 'package:clock_bloc/constants/colors.dart';
import 'package:clock_bloc/state_management/models/alarm_model.dart';
import 'package:clock_bloc/state_management/services/boxes.dart';
import 'package:clock_bloc/ui/design/alarm_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddAlarmWidget extends StatelessWidget {
  const AddAlarmWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
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

            showDialog(
              context: context,
              builder: (context) => AlarmDialog(
                onClickedDone: addAlarm,
              ),
            );
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
    );
  }

  void addAlarm(
    String title,
    String description,
    bool isActive,
    DateTime alarmTime,
    List<String> alarmDays,
  ) {
    final alarm = Alarm()
      ..title = title
      ..description = description
      ..isActive = isActive
      ..alarmTime = alarmTime
      ..alarmDays = alarmDays;

    final box = Boxes.getAlarms();
    box.add(alarm);
  }
}
