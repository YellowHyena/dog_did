import 'package:cloud_firestore/cloud_firestore.dart';
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
  int _counter = 0;
  // final DatabaseReference _testRef = FirebaseDatabase.instance.ref().child("test-Child");
  final controller = TextEditingController();
  void _incrementCounter() {
    setState(() {
      // _testRef.set(_counter);
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextField(controller: controller), actions: [
        IconButton(
            onPressed: () {
              final name = controller.text;

              createUser(name: name);
            },
            icon: Icon(Icons.add))
      ]),
      floatingActionButton: FancyButton(
        onPressed: () {
          final name = controller.text;
        },
        // text: _testRef.toString(),
      ),
      body: Schedule(),
    );
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
