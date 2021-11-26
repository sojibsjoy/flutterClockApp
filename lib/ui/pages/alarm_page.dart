import 'package:clock_bloc/state_management/models/alarm_model.dart';
import 'package:clock_bloc/state_management/services/boxes.dart';
import 'package:clock_bloc/ui/design/alarm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
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
          const SizedBox(
            height: 10,
          ),
          ValueListenableBuilder<Box<Alarm>>(
            valueListenable: Boxes.getAlarms().listenable(),
            builder: (context, box, _) {
              final alarms = box.values.toList().cast<Alarm>();
              // show the list of alarms
              return AlarmView(alarmList: alarms);
            },
          ),
        ],
      ),
    );
  }
}
