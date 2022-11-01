import 'package:flutter/material.dart';

class LoginContainerTemplate extends StatelessWidget {
  final dynamic children;

  LoginContainerTemplate({
    Key? key,
    this.children,
  }) : super(key: key);

  final appBar = AppBar(title: const Text("data"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
          mainAxisSize: MainAxisSize.max,
          children: children,
        ),
      ),
    );
  }
}
