import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_form.dart';

//https://www.youtube.com/watch?v=4vKiJZNPhss thanks!
//https://stackoverflow.com/a/66820328 thanks!

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ClipRect(
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.topCenter,
                    children: [
                      ImageFiltered(imageFilter: ImageFilter.blur(), child: Image.asset('assets/images/LoginDog.jpg', fit: BoxFit.cover)),
                      Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter))),
                      Padding(
                        padding: EdgeInsets.only(top: 400),
                        child: Column(
                          children: [
                            Text(
                              'Welcome to',
                              style: GoogleFonts.fuzzyBubbles(textStyle: const TextStyle(fontSize: 30, color: Colors.white)),
                            ),
                            Text(
                              'Dog Did',
                              style: GoogleFonts.fuzzyBubbles(textStyle: const TextStyle(fontSize: 50, color: Colors.white)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const LoginForm(),
            ],
          ),
        ),
      );
}
