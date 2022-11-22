import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/screens/dogs/dogs_page.dart';
import 'package:dog_did/screens/home/home_page.dart';
import 'package:dog_did/screens/schedule/schedule_page.dart';
import 'package:flutter/material.dart';

class DogDidScaffold extends StatefulWidget {
  const DogDidScaffold({super.key, required this.appBar, required this.body});
  final dynamic body;
  final dynamic appBar;

  @override
  State<DogDidScaffold> createState() => _DogDidScaffoldState();
}

class _DogDidScaffoldState extends State<DogDidScaffold> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme().primaryContainer,
              Colors.black,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: widget.appBar,
          body: widget.body,
        ));
  }
}
