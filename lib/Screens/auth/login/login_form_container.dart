import 'package:flutter/material.dart';

class LoginFormContainer extends StatefulWidget {
  const LoginFormContainer({super.key, required this.children, required this.formKey});
  final GlobalKey<FormState> formKey;
  final dynamic children;

  @override
  State<LoginFormContainer> createState() => _LoginFormContainerState();
}

class _LoginFormContainerState extends State<LoginFormContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.children,
        ),
      ),
    );
  }
}
