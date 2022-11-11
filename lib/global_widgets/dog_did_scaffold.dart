import 'package:flutter/material.dart';

class DogDidScaffold extends StatelessWidget {
  DogDidScaffold({super.key, required this.appBar, required this.body});
  var body;
  var appBar;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Colors.black,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: body,
        ));
  }
}
