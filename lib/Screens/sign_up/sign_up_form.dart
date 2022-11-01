import 'package:dog_did/screens/login/login_form_container.dart';
import 'package:dog_did/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../login/login_textfield.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _btnIsEnabled = false;

  void checkButtonValidation(String? string) => _formKey.currentState!.validate() ? setState(() => _btnIsEnabled = true) : setState(() => _btnIsEnabled = false);

  void validateAndSignUp() => _formKey.currentState!.validate() ? signUp() : null;
  Future signUp() async {
    Utils.loading(context);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e.message != null) Utils.showSnackBar(e.message.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      checkButtonValidation;
    });
    passwordController.addListener(() {
      checkButtonValidation;
    });
    rePasswordController.addListener(() {
      checkButtonValidation;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return LoginFormContainer(
      children: [
        LoginWidgetTextField(
          controller: emailController,
          labelText: 'email',
          validator: (email) => email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,
          buttoncheck: checkButtonValidation,
        ),
        const SizedBox(height: 4),
        LoginWidgetTextField(
          controller: passwordController,
          labelText: 'password',
          obscureText: true,
          validator: (password) => password!.length < 6 ? 'Password must be at least 6 characters' : null,
          buttoncheck: checkButtonValidation,
        ),
        const SizedBox(height: 4),
        LoginWidgetTextField(
          controller: rePasswordController,
          labelText: 'confirm password',
          obscureText: true,
          validator: (password) => password != passwordController.text ? 'Password must match' : null,
          buttoncheck: checkButtonValidation,
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: _btnIsEnabled ? theme.primary : theme.inversePrimary, disabledBackgroundColor: theme.inversePrimary),
          icon: _btnIsEnabled ? const Icon(Icons.lock_open_rounded, size: 32) : const Icon(Icons.lock_rounded, size: 32),
          label: const Text(
            'Sign up and log in',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: _btnIsEnabled ? validateAndSignUp : null,
        )
      ],
    );
  }
}
