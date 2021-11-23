import 'package:clock_bloc/constants/colors.dart';
import 'package:clock_bloc/state_management/database/data.dart';
import 'package:clock_bloc/state_management/models/alarm_info.dart';
// import 'package:clock_bloc/state_management/services/notification_api.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime? _alarmTime;
  // String? _alarmTimeString;
  // Future<List<AlarmInfo>>? _alarms;
  // List<AlarmInfo>? _currentAlarms;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.alarm_title,
            style: const TextStyle(
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          Expanded(
            child: ListView(
              children: alarms.map<Widget>((alarm) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      // colors: alarm.gradientColors,
                      colors: [Colors.purple, Colors.red],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        // color: alarm.gradientColors.last.withOpacity(0.4),
                        color: Colors.red.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 4,
                        offset: const Offset(4, 4),
                      )
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
                            children: const [
                              Icon(
                                Icons.label,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Office',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'avenir',
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: true,
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
                        children: const [
                          Text(
                            '07:00 AM',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'avenir',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 36,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }).followedBy([
                if (alarms.length < 5)
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
                        onPressed: () async {
                          // NotificationAPI.showNotification(
                          //   title: "Office",
                          //   body: "Wake Up! Time for Office!",
                          //   payload: 'sarah.abs',
                          // );
                          DateTime scheduleAlarmDateTime;
                          if (_alarmTime!.isAfter(DateTime.now())) {
                            scheduleAlarmDateTime = _alarmTime!;
                          } else {
                            scheduleAlarmDateTime =
                                _alarmTime!.add(const Duration(days: 1));
                          }
                          var alarmInfo = AlarmInfo(
                            title: "alarm",
                            alarmDateTime: scheduleAlarmDateTime,
                            gradientColorIndex: alarms.length,
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
                  )
                else
                  const Text('Only 2 alarm allowed'),
              ]).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
