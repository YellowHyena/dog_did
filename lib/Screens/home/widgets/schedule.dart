import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'schedule_item.dart';

class Schedule extends StatefulWidget {
  const Schedule({
    Key? key,
    required this.dogList,
  }) : super(key: key);

  final List<Iterable<MapEntry<String, dynamic>>> dogList;
  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    final dogname = 'unknown';
    for (var dog in widget.dogList) {
      inspect(dog);
    }
    return ListView(
      padding: const EdgeInsets.only(left: 50.0, top: 40.0),
      children: [
        for (var dog in widget.dogList) ...[
          for (var entry in dog.where((e) => e.value is Timestamp)) ...[
            ScheduleItem(date: (entry.value as Timestamp).toDate(), dog: 'dogge', activity: entry.key),
          ]
        ]
      ],
    );
  }
}
