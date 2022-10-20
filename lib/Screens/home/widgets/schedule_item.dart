import 'package:flutter/material.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({
    Key? key,
    required this.date,
    required this.dog,
    required this.activity,
  }) : super(key: key);

  final String date;
  final String dog;
  final String activity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(fontSize: 58),
          ),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 16, color: Colors.black),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 4.0),
              child: Column(children: [Text(dog), Text(activity)]),
            ),
          )
        ],
      ),
    );
  }
}
