import 'package:ecommerceapp/Widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoading = false;

  void handleStart() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    Get.off(() => BottomNavBarScreen(initialIndex: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff000000), Color(0xff005DFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/shopping_bag.gif",
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
             SizedBox(height: 20),
            Text(
              "Where Style",
              style: GoogleFonts.actor(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Meets Comfort",
              style: GoogleFonts.actor(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Join us to celebrate stylish, comfy footwear\nYour path to extraordinary style begins here",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator(color: Colors.black)
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(300, 76),
                    ),
                    onPressed: handleStart,
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
