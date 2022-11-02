import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../user_data.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.title});
  final String title;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Map<String, dynamic>> _sheduleList = [];
  // List _sheduleList = [];
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // if (_sheduleList.isEmpty) getSheduleList();
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
      // body: Schedule(dogList: _sheduleList),
      body: FutureBuilder<UserData?>(
        future: readUser(),
        builder: (context, snapshot) {
          inspect(snapshot.data);
          if (snapshot.hasData) return buildUser(snapshot.data);
          return const Text('Something went wrong!');
        },
      )
      // Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Text(
      //         'signed in as',
      //         style: TextStyle(fontSize: 10),
      //       ),
      //       const SizedBox(
      //         height: 4,
      //       ),
      //       Text(
      //         widget.user.email!,
      //         style: const TextStyle(fontSize: 20),
      //       )
      //     ],
      //   ),
      // ),
      );
  // Stream<List<User>> readUsers() => FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).snapshots().map((snapshot) => snapshot.UserData.fromJson(snapshot));
  Future<UserData?> readUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid);
    final snapshot = await docUser.get();
    inspect(snapshot.data());
    if (snapshot.exists) {
      return UserData.fromJson(snapshot.data()!);
    }
    return null;
  }

  Widget buildUser(UserData? user) => ListTile(
        leading: Text(user!.email),
        title: Text(user.id),
        subtitle: Text(user.name),
      );

  // Future getSheduleList() async {
  //   if (kDebugMode) {
  //     print('getting schedules');
  //   }
  //   var allSchedule = await FirebaseFirestore.instance.collection('users').doc('testUser').collection('allSchedule').get();
  //   var docs = allSchedule.docs.map((e) => e.data()).toList();
  //   inspect(docs);

  //   var dogList = docs.map((e) => e.entries).toList();

  //   setState(() {
  //     _sheduleList = dogList;
  //   });
  // }

  // Future getSingleDogList() async {
  //   var id = '3gTOhJYzwyBKZ4yvxnrv';
  //   var molly = await FirebaseFirestore.instance.collection('users').doc('testUser').collection('Dogs').doc(id).get();
  //   var docs = molly.data();

  //   inspect(docs);
  //   docs?.values.forEach(((element) => inspect(element)));
  //   // var dogList = docs.map((e) => e.entries).toList();

  //   setState(() {
  //     // _sheduleList = dogList;
  //   });
  // }

}
