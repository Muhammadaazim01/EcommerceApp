import 'package:ecommerceapp/Widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  void handleStart() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    // Navigate to next screen (replace with your actual screen)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => BottomNavBarScreen(initialIndex: 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff000000), Color(0xff005DFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/splash_screen.png"),
            const SizedBox(height: 20),
            Text(
              "Where Style",
              style: GoogleFonts.roboto(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Meets Comfort",
              style: GoogleFonts.roboto(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Join us to celebrate stylish, comfy footwear.\nYour path to extraordinary style begins here.",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(376, 76),
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
