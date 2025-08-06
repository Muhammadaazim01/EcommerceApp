import 'package:ecommerceapp/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Get.to(
        () => WelcomeScreen(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 1800),
      );
    });

    return Scaffold(
      body: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff000000), Color(0xff005DFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/splash_card.gif",
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),

                SizedBox(height: 20),

                // 👇 App Name
                Text(
                  'MA SHOPPING',
                  style: GoogleFonts.actor(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.5,
                    // fontFamily: 'Montserrat',
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: <Color>[Colors.white, Color(0xff000000)],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
