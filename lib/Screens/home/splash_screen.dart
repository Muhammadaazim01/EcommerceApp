import 'package:ecommerceapp/Screens/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Get.to(
        () => WelcomeScreen(),
        transition: Transition.cupertino,
        duration: Duration(milliseconds: 800),
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff000000), Color(0xff005DFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Text(
            'MA SHOPPING',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.5,
              fontFamily: 'Montserrat',
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: <Color>[Colors.white, Color(0xff000000)],
                ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
        ),
      ),
    );
  }
}
