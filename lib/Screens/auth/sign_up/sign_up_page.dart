import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/screens/auth/login/login_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../login/login_container_template.dart';
import 'sign_up_form.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onClickSignIn;

  const SignUpPage({
    Key? key,
    required this.onClickSignIn,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) => LoginContainerTemplate(
        children: [
          const LoginBackground(edgeInsertTop: 300),
          const SignUpForm(),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white),
              text: 'Already have an account? ',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = widget.onClickSignIn,
                  text: 'Sign in',
                  style: TextStyle(decoration: TextDecoration.underline, color: colorScheme.primary),
                )
              ],
            ),
          ),
        ],
      );
}
