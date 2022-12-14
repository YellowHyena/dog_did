import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/global_widgets/current_user.dart';
import 'package:dog_did/screens/home/main_scaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/auth/auth_page.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'global_widgets/utils.dart';

Future<void> main() async {
  GoogleFonts.config.allowRuntimeFetching = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

  FirebaseAuth.instance.userChanges().listen((User? user) async {
    if (user == null) {
      if (kDebugMode) {
        print('User is currently signed out!');
      }
    } else {
      currentUser = user;
      currentUserData = await getCurrentUserData();

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) => MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        title: 'Dog Did',
        theme: ThemeData(
            canvasColor: const Color.fromARGB(255, 51, 45, 43),
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
            colorScheme: colorScheme()),
        home: FutureBuilder(
          future: _firebaseApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (kDebugMode) {
                print(snapshot.error.toString());
              }
              return const Text("Someone let the dogs out and something went wrong!");
            } else if (snapshot.hasData) {
              return StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) => snapshot.hasData ? const MainScaffold() : const AuthPage(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
}
