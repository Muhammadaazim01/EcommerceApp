import 'package:ecommerceapp/Screens/address/address_controller.dart';
import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/payment_method/widgets/payment_controller.dart';
import 'package:ecommerceapp/Widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF512F), Color(0xFFF09819)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/success.gif",
                        width: 150,
                        height: 150,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Thank You!',
                        style: GoogleFonts.montserrat(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Your order has been placed successfully.\nYou will receive a confirmation soon.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.black54,
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
                                  final cartController =
                                      Get.find<CartController>();
                                  final paymentController =
                                      Get.find<PaymentController>();
                                  final addressController =
                                      Get.find<AddressController>();

                                  cartController.clearcart();
                                  paymentController.paymentSuccess.value =
                                      false;
                                  addressController.selectedAddress.value =
                                      null;

                                  Get.offAll(
                                    () => BottomNavBarScreen(initialIndex: 0),
                                  );
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF512F),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Back to Home',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
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
