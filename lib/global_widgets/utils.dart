// ignore_for_file: file_names

import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String text, Color color) {
    final snackBar = SnackBar(content: Text(text), backgroundColor: color);
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static loading(context) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(
            color: colorScheme().primary,
          ),
        ),
      );

  static confirmAction(String actionText, Function action, context) => showDialog(
        context: context,
        builder: (context) => (AlertDialog(
          backgroundColor: colorScheme().background,
          title: const Text('Confirm action'),
          content: Text('Are you sure you want to $actionText'),
          actions: [
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
                onPressed: () {
                  action();
                  Navigator.pop(context);
                },
                child: const Text('YES'))
          ],
        )),
      );
}
