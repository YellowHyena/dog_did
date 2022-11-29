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
}
