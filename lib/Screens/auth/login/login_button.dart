import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key, required this.onPressed, required this.text, required this.enabled, required this.enabledIcon, required this.disabledIcon});
  final Function()? onPressed;
  final String text;
  final bool enabled;
  final IconData enabledIcon;
  final IconData disabledIcon;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: widget.enabled ? theme.primary : theme.inversePrimary, disabledBackgroundColor: theme.inversePrimary),
      icon: widget.enabled ? Icon(widget.enabledIcon, size: 32) : Icon(widget.disabledIcon, size: 32),
      label: Text(
        widget.text,
        style: const TextStyle(fontSize: 24),
      ),
      onPressed: widget.enabled ? widget.onPressed : null,
    );
  }
}
