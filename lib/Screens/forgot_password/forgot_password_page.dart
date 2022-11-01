import 'package:dog_did/screens/login/login_container_template.dart';
import 'package:dog_did/screens/sign_up/sign_up_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../login/login_background.dart';
import '../login/login_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool _btnIsEnabled = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void checkButtonValidation(String? string) => _formKey.currentState!.validate() ? setState(() => _btnIsEnabled = true) : setState(() => _btnIsEnabled = false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return LoginContainerTemplate(
      children: [
        const LoginBackground(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: LoginWidgetTextField(
            controller: emailController,
            labelText: 'email',
            validator: (email) => email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,
            buttoncheck: checkButtonValidation,
          ),
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
          onPressed: _btnIsEnabled ? null : null, //TODO send email
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
      ],
    );
  }
}
