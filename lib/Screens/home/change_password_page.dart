import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/global_widgets/current_user.dart';
import 'package:dog_did/global_widgets/dog_did_scaffold.dart';
import 'package:dog_did/screens/auth/login/login_button.dart';
import 'package:dog_did/screens/auth/login/login_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  void dispose() {
    currentController.dispose();
    newController.dispose();
    confirmNewController.dispose();
    super.dispose();
  }

  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmNewController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? getCurrentPassword(String? sdf) {
    return 'balls';
  }

  // @override
  // void initState() {
  //   super.initState();
  //   currentController.addListener(() => checkButtonValidation);
  //   newController.addListener(() => checkButtonValidation);
  //   newController.addListener(() => checkButtonValidation);
  // }
  String? _input;

  @override
  Widget build(BuildContext context) => DogDidScaffold(
          body: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (current) => current!.length < 6 ? 'passwred most be låpnger!' : null,
            onSaved: (newValue) => _input = newValue,
            controller: currentController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorScheme().primary)),
              labelText: 'Current password',
              labelStyle: TextStyle(color: colorScheme().primary),
              filled: true,
              fillColor: colorScheme().primaryContainer,
            ),
            // onChanged: widget.onChanged,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
          ),
          // LoginButton(onPressed: () => FirebaseAuth.instance.currentUser?.updatePassword(currentController.text), text: text, enabled: enabled, enabledIcon: enabledIcon, disabledIcon: disabledIcon),
        ],
      ));
}
