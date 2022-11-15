import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/screens/auth/login/login_button.dart';
import 'package:dog_did/screens/auth/login/login_form_container.dart';
import 'package:dog_did/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      Utils.showSnackBar('An email with a reset link for your password has been sent', colorScheme.background);
    } on FirebaseAuthException catch (e) {
      if (e.message != null) Utils.showSnackBar(e.message.toString(), colorScheme.error);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => LoginFormContainer(formKey: formKey, children: [
        LoginWidgetTextField(
          controller: emailController,
          labelText: 'email',
          validator: (email) => email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,
          onChanged: checkButtonValidation,
        ),
        const SizedBox(height: 20),
        LoginButton(
          onPressed: resetPassword,
          text: 'Reset Password',
          enabled: _btnIsEnabled,
          disabledIcon: Icons.mail,
          enabledIcon: Icons.outbond_rounded,
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
