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
  // List<Map<String, dynamic>> _sheduleList = [];
  List<Iterable<MapEntry<String, dynamic>>> _sheduleList = [];

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

      body: Schedule(dogList: _sheduleList),
    );
  }

  Future getSheduleList() async {
    var data = await FirebaseFirestore.instance.collection('users').doc('testUser').collection('allSchedule').get();
    var dogs = data.docs.map((e) => e.data()).toList();
    var dog = dogs.map((e) => e.entries).toList();

    // inspect(dog);
    // inspect(dogs);
    setState(() {
      // _sheduleList = dog;
      _sheduleList = dog;
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
