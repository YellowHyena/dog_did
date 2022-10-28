import 'package:flutter/material.dart';

class LoginWidgetTextField extends StatefulWidget {
  const LoginWidgetTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.primeColor = const Color.fromARGB(255, 255, 111, 54),
    this.textfieldFillColor = const Color.fromARGB(255, 54, 54, 54),
    required this.validator,
    required this.buttoncheck,
  }) : super(key: key);

  final void Function(String?) buttoncheck;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final Color primeColor;
  final Color textfieldFillColor;
  final String labelText;
  final bool obscureText;

  @override
  State<LoginWidgetTextField> createState() => _LoginWidgetTextFieldState();
}

class _LoginWidgetTextFieldState extends State<LoginWidgetTextField> {
  var _input;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      onSaved: (newValue) => _input = newValue,
      controller: widget.controller,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: widget.primeColor)),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: widget.primeColor),
        filled: true,
        fillColor: widget.textfieldFillColor,
      ),
      onChanged: widget.buttoncheck,
      style: const TextStyle(color: Colors.white),
      obscureText: widget.obscureText,
    );
  }
}
