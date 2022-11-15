import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_did/global_widgets/dog_did_scaffold.dart';
import 'package:dog_did/screens/home/dogs_page/dog_tile.dart';
import 'package:dog_did/user_data.dart';
import 'package:flutter/material.dart';

import '../../../dog_data.dart';
import 'dog_profile.dart';

class DogsPage extends StatefulWidget {
  const DogsPage({super.key, required this.userData});
  final UserData? userData;
  @override
  State<DogsPage> createState() => _DogsPageState();
}

class _DogsPageState extends State<DogsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return DogDidScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Dogs'),
        actions: [
          IconButton(
              onPressed: () async {
                DogData dog = await createDogInDatabase(widget.userData);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DogProfile(dog: dog)));
              },
              icon: Icon(
                Icons.add_rounded,
                color: theme.primary,
              ))
        ],
      ),
      body: StreamBuilder<List<DogData>>(
          stream: readDogs(widget.userData),
          builder: (context, snapshot) {
            inspect(snapshot);
            inspect(snapshot.error);
            if (snapshot.hasError) {
              return const Text('Something went wrong!');
            } else if (snapshot.hasData) {
              return ListView(children: snapshot.data!.map((e) => DogTile(dog: e)).toList());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

// Widget buildDog(DogData dogData) =>

Stream<List<DogData>> readDogs(UserData? userData) => FirebaseFirestore.instance.collection('users').doc(userData!.id).collection('dogs').snapshots().map((snapshot) => snapshot.docs.map((doc) => DogData.fromJson(doc.data())).toList());

Future<DogData> createDogInDatabase(UserData? user) async {
  final docDog = FirebaseFirestore.instance.collection('users').doc(user?.id).collection('dogs').doc();

  final dogToCreate = DogData(id: docDog.id, name: '', age: 0, breed: '', description: '', isFemale: true, imageURL: '', docPath: docDog.path);
  final json = dogToCreate.toJson();
  await docDog.set(json);
  return dogToCreate;
}
// final snapshot = await docUser.get();
// inspect(snapshot.data());
// if (snapshot.docs.isNotEmpty) {
//   userData = UserData.fromJson(snapshot.data()!);

//   inspect(userData);
//   return UserData.fromJson(snapshot.data()!);
// }
// return null;
