import 'package:flutter/material.dart';
import 'Screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Did',
      theme: ThemeData(),
      home: const HomePage(title: 'DogDid Home Page'),
    );
  }
}
