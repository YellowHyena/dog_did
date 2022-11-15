import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/screens/auth/login/login_container_template.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../forgot_password/forgot_password_page.dart';
import 'login_background.dart';
import 'login_form.dart';

//https://www.youtube.com/watch?v=4vKiJZNPhss thanks!
//https://stackoverflow.com/a/66820328 thanks!

class LoginPage extends StatefulWidget {
  final VoidCallback onClickSignUp;

  const LoginPage({
    Key? key,
    required this.onClickSignUp,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) => LoginContainerTemplate(
        children: [
          const LoginBackground(),
          const LoginForm(),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white),
              text: 'New user? ',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = widget.onClickSignUp,
                  text: 'Sign up',
                  style: TextStyle(decoration: TextDecoration.underline, color: colorScheme.primary),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          GestureDetector(
              child: Text(
                'Forgot Password?',
                style: TextStyle(decoration: TextDecoration.underline, color: colorScheme.primary),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPasswordPage())))
        ],
      );
}
