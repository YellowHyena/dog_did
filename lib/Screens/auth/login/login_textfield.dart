import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:flutter/material.dart';

class LoginWidgetTextField extends StatefulWidget {
  const LoginWidgetTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);

  final void Function(String?) onChanged;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  @override
  State<LoginWidgetTextField> createState() => _LoginWidgetTextFieldState();
}

class _LoginWidgetTextFieldState extends State<LoginWidgetTextField> {
  // ignore: unused_field
  String? _input;

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
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorScheme().primary)),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: colorScheme().primary),
        filled: true,
        fillColor: colorScheme().primaryContainer,
      ),
      onChanged: widget.onChanged,
      style: const TextStyle(color: Colors.white),
      obscureText: widget.obscureText,
    );
  }
}
