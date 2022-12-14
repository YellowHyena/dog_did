import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:flutter/material.dart';

class DogDidScaffold extends StatelessWidget {
  const DogDidScaffold({super.key, this.appBar, required this.body});
  final dynamic body;
  final dynamic appBar;

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
          appBar: appBar,
          body: body,
        ));
  }
}
