import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/global_widgets/current_user.dart';
import 'package:dog_did/global_widgets/dog_did_scaffold.dart';
import 'package:dog_did/global_widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    currentController.dispose();
    super.dispose();
  }

  final currentController = TextEditingController();

  deleteAccount() async {
    final email = currentUser?.email ?? '';
    final AuthCredential credentials = EmailAuthProvider.credential(email: email, password: currentController.text);
    await currentUser?.reauthenticateWithCredential(credentials);
    try {
      //TODO make this acctually delete everything that relates to user.
      // await FirebaseAuth.instance.signOut();
      // await FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).delete();

      // await FirebaseStorage.instance.ref().child('user').child(currentUser!.uid).listAll().then((value) => value.items.forEach((element) {
      //       element.delete();
      //     }));

      // await currentUser?.delete();
    } catch (e) {
      Utils.showSnackBar(e.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) => DogDidScaffold(
        appBar: AppBar(title: const Text('Home page')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: Row(
                  children: const [
                    Text(
                      'Sign Out ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.logout_rounded),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => (AlertDialog(
                      backgroundColor: colorScheme().background,
                      title: const Text('Confirm action'),
                      content: Column(
                        children: [
                          Text('DELETE USER?'),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (current) => current!.length < 6 ? 'Password must be more than 6 symbols!' : null,
                            // onSaved: (newValue) => _input = newValue,
                            controller: currentController,
                            cursorColor: Colors.white,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorScheme().primary)),
                              labelText: 'Current password',
                              labelStyle: TextStyle(color: colorScheme().primaryContainer),
                              filled: true,
                              fillColor: colorScheme().primaryContainer,
                            ),
                            // onChanged: widget.onChanged,
                            style: const TextStyle(color: Colors.white),
                            obscureText: false,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text('CANCEL'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                            onPressed: () {
                              deleteAccount();

                              Navigator.pop(context);
                            },
                            child: const Text('YES'))
                      ],
                    )),
                  );
                  // Utils.confirmActionWithForm('delete your account? This action is ireversible.', deleteAccount, context);
                },
                child: Row(
                  children: const [
                    Text(
                      'Delete Account',
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.delete),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
