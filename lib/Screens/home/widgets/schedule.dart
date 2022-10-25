import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'schedule_item.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final date = "10:30";
  final dog = "Molly";
  final activity = "Walk";

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 50.0, top: 40.0),
      children: <Widget>[
        // ScheduleItem(date: date, dog: dog, activity: activity),
        // ScheduleItem(date: date, dog: dog, activity: activity),
        // ScheduleItem(date: date, dog: dog, activity: activity),
      ],
    );
  }
}
