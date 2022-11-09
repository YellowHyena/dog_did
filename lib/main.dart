import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/auth/auth_page.dart';
import 'screens/home/home_page.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  FirebaseAuth.instance.userChanges().listen((User? user) {
    if (user == null) {
      if (kDebugMode) {
        print('User is currently signed out!');
      }
    } else {
      if (kDebugMode) {
        print('User is signed in!');
      }
    }
  });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        title: 'Dog Did',
        theme: ThemeData(
            canvasColor: const Color.fromARGB(255, 51, 45, 43),
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 111, 54),
              primary: const Color.fromARGB(255, 255, 111, 54),
              primaryContainer: const Color.fromARGB(255, 54, 54, 54),
              inversePrimary: const Color.fromARGB(255, 129, 92, 78),
              background: Colors.black,
              tertiary: const Color.fromARGB(255, 141, 141, 141),
            )),
        home: FutureBuilder(
          future: _firebaseApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (kDebugMode) {
                print(snapshot.error.toString());
              }
              return const Text("Someone let the dogs out and something went wrong!");
            } else if (snapshot.hasData) {
              return Scaffold(
                body: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) => snapshot.hasData ? HomePage(title: 'home page') : const AuthPage(),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
}
