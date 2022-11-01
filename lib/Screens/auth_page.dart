import 'package:dog_did/screens/login/login_page.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'sign_up/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin ? LoginPage(onClickSignUp: toggle) : SignUpPage(onClickSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
