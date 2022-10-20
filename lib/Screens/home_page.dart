import 'package:dog_did/screens/test_widget.dart';
import 'package:flutter/material.dart';
import 'test_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FancyButton(
      onPressed: _incrementCounter,
      text: "hej",
    ));
  }
}
