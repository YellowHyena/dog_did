import 'package:dog_did/screens/auth/forgot_password/forgot_password_form.dart';
import 'package:dog_did/screens/auth/login/login_container_template.dart';
import 'package:flutter/material.dart';
import '../login/login_background.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) => LoginContainerTemplate(
        children: const [
          LoginBackground(),
          ForgotPasswordForm(),
        ],
      );
}
