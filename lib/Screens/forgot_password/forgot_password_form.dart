import 'package:dog_did/screens/login/login_form_container.dart';
import 'package:dog_did/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../login/login_textfield.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => checkButtonValidation);
  }

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _btnIsEnabled = false;

  void checkButtonValidation(String? string) => formKey.currentState!.validate() ? setState(() => _btnIsEnabled = true) : setState(() => _btnIsEnabled = false);
  Future resetPassword() async {
    Utils.loading(context);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('An email with a reset link for your password has been sent');
    } on FirebaseAuthException catch (e) {
      if (e.message != null) Utils.showSnackBar(e.message.toString());
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return LoginFormContainer(formKey: formKey, children: [
      LoginWidgetTextField(
        controller: emailController,
        labelText: 'email',
        validator: (email) => email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,
        buttoncheck: checkButtonValidation,
      ),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: _btnIsEnabled ? theme.primary : theme.inversePrimary, disabledBackgroundColor: theme.inversePrimary),
        icon: _btnIsEnabled ? const Icon(Icons.outgoing_mail, size: 32) : const Icon(Icons.mail, size: 32),
        label: const Text(
          'Reset Password',
          style: TextStyle(fontSize: 24),
        ),
        onPressed: _btnIsEnabled ? resetPassword : null,
      ),
      Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
    ]);
  }
}
