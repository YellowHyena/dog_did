import 'package:dog_did/screens/login/login_form_container.dart';
import 'package:dog_did/utils.dart';
import 'package:dog_did/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_textfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future signIn() async {
    Utils.loading(context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.message != null) Utils.showSnackBar(e.message.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  bool _btnIsEnabled = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // dialogPopUp() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Error änna'),
  //         content: const Text('That user does not exist. Please check each field for errors'),
  //         actions: <Widget>[FloatingActionButton(onPressed: () => Navigator.of(context).pop())],
  //       );
  //     },
  //   );
  // }

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

  void checkButtonValidation(String? string) => _formKey.currentState!.validate() ? setState(() => _btnIsEnabled = true) : setState(() => _btnIsEnabled = false);

  void validateAndSignIn() => _formKey.currentState!.validate() ? signIn() : null;

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
        const SizedBox(
          height: 20,
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: _btnIsEnabled ? theme.primary : theme.inversePrimary, disabledBackgroundColor: theme.inversePrimary),
          icon: _btnIsEnabled ? const Icon(Icons.lock_open_rounded, size: 32) : const Icon(Icons.lock_rounded, size: 32),
          label: const Text(
            'Sign in',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: _btnIsEnabled ? validateAndSignIn : null,
        )
      ],
    );
  }
}
