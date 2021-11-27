import 'package:clock_bloc/state_management/models/alarm_model.dart';
import 'package:flutter/material.dart';

class AlarmDialog extends StatefulWidget {
  final Alarm? alarm;
  final Function(
    String title,
    String description,
    bool isActive,
    DateTime alarmTime,
    List<String> alarmDays,
  ) onClickedDone;
  const AlarmDialog({
    Key? key,
    this.alarm,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _AlarmDialogState createState() => _AlarmDialogState();
}

class _AlarmDialogState extends State<AlarmDialog> {
  final formKey = GlobalKey<FormState>();
  final titleCon = TextEditingController();
  final desCon = TextEditingController();
  DateTime? alarmDateTime;
  List<String>? alarmDays;
  bool isActive = true;

  @override
  void initState() {
    super.initState();

    if (widget.alarm != null) {
      final alarm = widget.alarm!;

      titleCon.text = alarm.title;
      desCon.text = alarm.description;
      isActive = alarm.isActive;
      alarmDateTime = alarm.alarmTime;
      alarmDays = alarm.alarmDays;
    }
  }

  @override
  void dispose() {
    titleCon.dispose();
    desCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.alarm != null;
    final title = isEditing ? 'Edit Alarm' : 'Add Alarm';
    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              buildTitle(),
              const SizedBox(height: 8),
              buildDes(),
              const SizedBox(height: 8),
              // buildDateTime(),
              // const SizedBox(height: 8),
              // buildDays(),
            ],
          ),
        ),
      ),
      actions: [
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildTitle() => TextFormField(
        controller: titleCon,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Title',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a title' : null,
      );

  Widget buildDes() => TextFormField(
        controller: desCon,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Description',
        ),
        validator: (des) => des != null && des.isEmpty ? 'Enter a title' : null,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      onPressed: () {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final title = titleCon.text;
          final description = desCon.text;
          widget.onClickedDone(
            title,
            description,
            true,
            DateTime.now().add(
              const Duration(hours: 1, minutes: 4),
            ),
            ['Sun', 'Mon', 'Tue'],
          );

          Navigator.of(context).pop();
        }
      },
      child: Text(text),
    );
  }
}
