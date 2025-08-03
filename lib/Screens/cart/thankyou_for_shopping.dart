import 'package:ecommerceapp/Widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  bool _isLoading = false;
  bool _buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ✅ Lottie Animation
                    Image.asset(
                      "assets/images/check_animation.gif",
                      width: 150,
                      height: 150,
                      //  repeat: false,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Thank You!',
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Your order has been placed successfully.\nYou will receive a confirmation soon.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _buttonPressed
                          ? null
                          : () {
                              setState(() {
                                _isLoading = true;
                                _buttonPressed = true;
                              });
                              Future.delayed(const Duration(seconds: 2), () {
                                Get.offAll(
                                  () =>
                                      const BottomNavBarScreen(initialIndex: 0),
                                );
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff005DFF),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Back to Home',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
