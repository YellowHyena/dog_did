import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dog_did/screens/home/widgets/schedule.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.title});

  final String title;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Map<String, dynamic>> _sheduleList = [];
  List _sheduleList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_sheduleList.isEmpty) getSheduleList();
    // getSingleDogList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Home page'), actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ]),
        body: Schedule(dogList: _sheduleList),
      );

  Future getSheduleList() async {
    if (kDebugMode) {
      print('getting schedules');
    }
    var allSchedule = await FirebaseFirestore.instance.collection('users').doc('testUser').collection('allSchedule').get();
    var docs = allSchedule.docs.map((e) => e.data()).toList();
    inspect(docs);

    var dogList = docs.map((e) => e.entries).toList();

    setState(() {
      _sheduleList = dogList;
    });
  }

  Future getSingleDogList() async {
    var id = '3gTOhJYzwyBKZ4yvxnrv';
    var molly = await FirebaseFirestore.instance.collection('users').doc('testUser').collection('Dogs').doc(id).get();
    var docs = molly.data();

    inspect(docs);
    docs?.values.forEach(((element) => inspect(element)));
    // var dogList = docs.map((e) => e.entries).toList();

    setState(() {
      // _sheduleList = dogList;
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
