import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_did/global_widgets/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? currentUser;
UserData? currentUserData;

getCurrentUserData() async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    currentUserData = UserData.fromJson(snapshot.data()!);
  }
}
