import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_did/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? currentUser;
UserData? currentUserData;

Future<UserData?> getCurrentUserData() async {
  // if (userData != null) return userData;

  final docUser = FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    // setState(() {
    //   userData = UserData.fromJson(snapshot.data()!);
    // });

    return UserData.fromJson(snapshot.data()!);
  }
  return null;
}
