import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../user_data.dart';
import 'dogs_page/dogs_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.title});
  final String title;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserData? userData;
  // List<Map<String, dynamic>> _sheduleList = [];
  // List _sheduleList = [];
  final currentUser = FirebaseAuth.instance.currentUser;
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // if (_sheduleList.isEmpty) getSheduleList();
  //   // getSingleDogList();
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Home page'), actions: [IconButton(icon: const Icon(Icons.logout_outlined), onPressed: () => FirebaseAuth.instance.signOut())]),
        body: Column(
          children: [
            FutureBuilder<UserData?>(
                future: readUser(),
                builder: (context, snapshot) {
                  // inspect(snapshot.data);
                  if (snapshot.hasData) return buildUser(snapshot.data);
                  return const Text('Something went wrong!');
                }),
            FloatingActionButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DogsPage(userData: userData)))),
          ],
        ),
      );

  Future<UserData?> readUser() async {
    if (userData != null) return userData;

    final docUser = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid);
    final snapshot = await docUser.get();
    // inspect(snapshot.data());
    if (snapshot.exists) {
      setState(() {
        userData = UserData.fromJson(snapshot.data()!);
      });
      // inspect(userData);

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
  //   // if (kDebugMode) {
  //   //   print('getting schedules');
  //   // }
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
