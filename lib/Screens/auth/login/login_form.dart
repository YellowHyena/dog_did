import 'package:dog_did/global_widgets/current_user.dart';
import 'package:dog_did/screens/auth/login/login_button.dart';
import 'package:dog_did/screens/auth/login/login_form_container.dart';
import 'package:dog_did/user_data.dart';
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
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => checkButtonValidation);
    passwordController.addListener(() => checkButtonValidation);
  }

  bool _btnIsEnabled = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future signIn() async {
    Utils.loading(context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.message != null) Utils.showSnackBar(e.message.toString(), Theme.of(context).colorScheme.error);
    }
    currentUser = FirebaseAuth.instance.currentUser;
    currentUserData = await getCurrentUserData() as UserData?;
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void checkButtonValidation(String? string) => formKey.currentState!.validate() ? setState(() => _btnIsEnabled = true) : setState(() => _btnIsEnabled = false);

  void validateAndSignIn() => formKey.currentState!.validate() ? signIn() : null;

  @override
  Widget build(BuildContext context) => LoginFormContainer(
        formKey: formKey,
        children: [
          LoginWidgetTextField(
            controller: emailController,
            labelText: 'email',
            validator: (email) => email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,
            onChanged: checkButtonValidation,
          ),
          const SizedBox(height: 4),
          LoginWidgetTextField(
            controller: passwordController,
            labelText: 'password',
            obscureText: true,
            validator: (password) => password!.length < 6 ? 'Password must be at least 6 characters' : null,
            onChanged: checkButtonValidation,
          ),
          const SizedBox(height: 20),
          LoginButton(
            onPressed: validateAndSignIn,
            text: 'Sign In',
            enabled: _btnIsEnabled,
            disabledIcon: Icons.lock_rounded,
            enabledIcon: Icons.lock_open_rounded,
          ),
        ],
      );
}
