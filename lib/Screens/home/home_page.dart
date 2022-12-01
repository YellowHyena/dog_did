import 'package:dog_did/global_widgets/dog_did_scaffold.dart';
import 'package:dog_did/screens/home/change_password_page.dart';
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
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChangePasswordPage())),
                child: Row(
                  children: const [
                    Text(
                      'Change password',
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.logout_rounded),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
