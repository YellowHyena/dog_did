import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home/home_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Did',
      theme: ThemeData(),
      // home: HomePage(title: 'Dog Did'),
      home: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print('ERROR här: ${snapshot.error.toString()}');
            return const Text("Someone let the dogs out and something went wrong!");
          } else if (snapshot.hasData) {
            return const HomePage(title: 'DogDid Home Page');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
