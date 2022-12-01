import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'current_user.dart';

class DogData {
  final String id;
  final String description;
  final String breed;
  final bool isFemale;
  final String name;
  final int age;
  final String imageURL;
  final String docPath;

  DogData({
    required this.id,
    required this.name,
    required this.age,
    required this.breed,
    required this.description,
    required this.isFemale,
    required this.imageURL,
    required this.docPath,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'breed': breed,
        'description': description,
        'isFemale': isFemale,
        'docPath': docPath,
        'imageURL': imageURL,
      };
  static DogData fromJson(Map<String, dynamic> json) => DogData(name: json['name'], age: json['age'], id: json['id'], breed: json['breed'], description: json['description'], isFemale: json['isFemale'], imageURL: json['imageURL'], docPath: json['docPath']);

  static Future<DogData> createDogInDatabase() async {
    final docDog = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).collection('dogs').doc();

    final dogToCreate = DogData(id: docDog.id, name: 'New Dog', age: 0, breed: '', description: '', isFemale: true, imageURL: '', docPath: docDog.path);
    final json = dogToCreate.toJson();
    await docDog.set(json);
    return dogToCreate;
  }

  static Stream<List<DogData>> readDogs() => FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).collection('dogs').snapshots().map((snapshot) => snapshot.docs.map((doc) => DogData.fromJson(doc.data())).toList());

  static delete(DogData dog) async {
    await FirebaseFirestore.instance.doc(dog.docPath).delete();
    inspect(dog.imageURL);
    Reference imgDir = FirebaseStorage.instance.ref().child('user').child(currentUser!.uid).child(dog.id);
    await imgDir.delete();
  }
}
