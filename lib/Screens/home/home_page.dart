import 'package:dog_did/global_widgets/dog_did_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  // final user = FirebaseAuth.instance.currentUser!;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // UserData? userData;
  // final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) => DogDidScaffold(
        appBar: AppBar(title: const Text('Home page'), actions: [IconButton(icon: const Icon(Icons.logout_outlined), onPressed: () => FirebaseAuth.instance.signOut())]),
        body: Column(
          children: [
            // FutureBuilder<UserData?>(
            //     future: readUser(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) return buildUser(snapshot.data);
            //       return const Text('Something went wrong!');
            //     }),
            // TextButton(
            //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DogsPage(userData: userData))),
            //   child: Row(children: [
            //     Text(
            //       'Dog page',
            //       style: TextStyle(fontSize: 20),
            //     ),
            //     Icon(Icons.arrow_forward_rounded)
            //   ]),
            // ),
          ],
        ),
      );

  // Widget buildUser(UserData? user) => ListTile(
  //       leading: Text(user!.email),
  //       title: Text(user.id),
  //       subtitle: Text(user.name),
  //     );

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
