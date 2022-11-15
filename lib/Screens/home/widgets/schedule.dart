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

  final List dogList;
  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
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

  // void getSortedList() {
  //   // for (var docs in widget.dogList) {
  //     // for (var entry in docs) {

  //     // }
  //     // for (var entry in dog.where((e) => e.value is Timestamp)) {
  //     //   ScheduleItem(date: (entry.value as Timestamp).toDate(), dog: 'dogge', activity: entry.key);
  //     // }
  //   }

  //   // var unsortedList = widget.dogList;
  //   // List<Iterable<MapEntry<String, dynamic>>> sortedList = [];

  //   // for (var dog in unsortedList) {
  //   //   for (var entry in dog.where((entry) => entry.value is Timestamp)) {
  //   //     // sortedList.add((entry.value as Timestamp).toDate());

  //   //     sortedList.add((entry));
  //   //   }
  //   // }
  //   // inspect(sortedList);

  //   // sortedList.sort((a, b) => a.compareTo(b));
  //   // inspect(sortedList);
  // }
}
