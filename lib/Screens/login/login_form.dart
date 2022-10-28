import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_textfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future signIn() async => await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
  bool _enabledBtn = false;
  final buttonEnabledColor = const Color.fromARGB(255, 255, 111, 54);
  final buttonDisabledColor = const Color.fromARGB(255, 129, 92, 78);
  var buttonColor = const Color.fromARGB(255, 129, 92, 78);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  dialogPopUp() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: const Text('Error änna'), content: const Text('That user does not exist. Please check each field for errors'), actions: <Widget>[FloatingActionButton(onPressed: () => Navigator.of(context).pop())]);
        });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
  }

  void checkButtonValidation(String? string) {
    _formKey.currentState!.validate()
        ? setState(() {
            _enabledBtn = true;
          })
        : setState(() {
            _enabledBtn = false;
          });
  }

  void validateAndSignIn() => _formKey.currentState!.validate() ? signIn() : null;

  String? validateEmail(String? fieldValue) {
    if (fieldValue!.isEmpty) return 'Email cannot be empty';
    if (!fieldValue.contains('@')) return 'Email must contain "@"';
    if (!fieldValue.contains('.')) return 'Email must contain "."';
    return null;
  }

  String? validatePassword(String? fieldValue) {
    if (fieldValue!.isEmpty) {
      // setState(() {
      //   _enabledBtn = false;
      // });
    }

    if (fieldValue.length < 6) {
      // setState(() {
      //   _enabledBtn = false;
      // });

      return 'Password must be longer than 6 symbols';
    }
    // setState(() {
    //   _enabledBtn = true;
    // });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginWidgetTextField(
              controller: emailController,
              labelText: 'email',
              validator: validateEmail,
              buttoncheck: checkButtonValidation,
            ),
            const SizedBox(height: 4),
            LoginWidgetTextField(
              controller: passwordController,
              labelText: 'password',
              obscureText: true,
              validator: validatePassword,
              buttoncheck: checkButtonValidation,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: _enabledBtn ? buttonEnabledColor : buttonDisabledColor, disabledBackgroundColor: buttonDisabledColor),
              icon: _enabledBtn ? const Icon(Icons.lock_open_rounded, size: 32) : const Icon(Icons.lock_rounded, size: 32),
              label: const Text(
                'Sign in',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: _enabledBtn ? validateAndSignIn : null,
            )
          ],
        ),
      ),
    );
  }
}
