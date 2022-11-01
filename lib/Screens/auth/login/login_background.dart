import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key, this.edgeInsertTop = 400});
  final double edgeInsertTop;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: [
            ImageFiltered(imageFilter: ImageFilter.blur(), child: Image.asset('assets/images/LoginDog.jpg', fit: BoxFit.cover)),
            Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter))),
            Padding(
              padding: EdgeInsets.only(top: edgeInsertTop),
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
    );
  }
}
