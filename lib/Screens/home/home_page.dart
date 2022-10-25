import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_did/screens/home/widgets/schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:dog_did/screens/home/widgets/schedule.dart';

import '../test_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _sheduleList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getSheduleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: TextField(controller: controller), actions: [
      //   IconButton(
      //       onPressed: () {
      //         final name = controller.text;

      //         createUser(name: name);
      //       },
      //       icon: Icon(Icons.add))
      // ]),
      // floatingActionButton: FancyButton(
      //   onPressed: () {
      //     final name = controller.text;
      //   },
      //   // text: _testRef.toString(),
      // ),

      body: SafeArea(
          child: ListView.builder(
        itemBuilder: (context, index) {
          final item = _sheduleList[index];
          var activity = 'Walk';
          DateTime date;
          inspect(item.entries);
          for (var i in item.entries) {
            // inspect(i.value);
            if (i.value is Timestamp) {
              date = (i.value as Timestamp).toDate();
              // return Text('${i.key}${date.hour}:${date.minute}');
              return ScheduleItem(date: date, dog: 'hunden', activity: i.key);
            } else {
              return Text(i.key);
            }
          }
          return Text('nope');
          // if (item.containsKey(activity)) {
          //   date = (item[activity] as Timestamp).toDate();
          //   return Text('$activity  ${date.hour}:${date.minute}');
          // }
          // return Text('data');
        },
        itemCount: _sheduleList.length,
      )),
    );
  }

  Future getSheduleList() async {
    var data = await FirebaseFirestore.instance.collection('users').doc('testUser').collection('allSchedule').get();
    var dogs = data.docs.map((e) => e.data()).toList();
    // inspect(dogs);
    setState(() {
      _sheduleList = dogs;
    });
  }

  Future createUser({required String name}) async {
    //ref to document
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    //json to be added
    final json = {
      'id': docUser.id,
      'name': name,
      'dog': true,
      'age': 3,
    };

    //create doc and write to firebase
    await docUser.set(json);
  }
}
