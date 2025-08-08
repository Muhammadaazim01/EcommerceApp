// lib/controllers/payment_controller.dart

import 'package:ecommerceapp/Screens/payment_method/widgets/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  RxBool isLoading = false.obs;

  final String amount = "5"; // 💵 $5.00 — You can change this

  void makePayment() async {
    isLoading.value = true;

    try {
      // STEP 1: Create payment intent from backend
      final paymentIntentData = await PaymentService.createPaymentIntent(
        amount: amount,
      );

      final clientSecret = paymentIntentData['clientSecret'];
      print("🧾 Client Secret: $clientSecret");

      // STEP 2: Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Shopping Hub by Aazim',
          style: ThemeMode.light,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              background: Colors.white,
              componentBackground: Colors.white,
              componentBorder: Colors.black,
              primaryText: Colors.black,
              placeholderText: Colors.grey,
              primary: Colors.blue,
              componentText: Colors.black,
            ),
          ),
        ),
      );

      // STEP 3: Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      // STEP 4: Show success message
      Get.snackbar(
        "✅ Payment Successful",
        "Your payment was successful.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.black,
      );
    } catch (e) {
      print("❌ Error during payment: $e");
      Get.snackbar(
        "❌ Payment Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
