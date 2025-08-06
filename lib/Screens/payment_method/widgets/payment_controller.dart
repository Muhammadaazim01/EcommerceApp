import 'package:ecommerceapp/Screens/payment_method/widgets/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  RxBool isLoading = false.obs;

  final String amount = "100"; // 💰 Set static or dynamic amount

  void makePayment() async {
    isLoading.value = true;

    try {
      final paymentIntentData = await PaymentService.createPaymentIntent(
        amount: amount,
      );

      print("🧾 Client Secret: ${paymentIntentData['clientSecret']}");

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['clientSecret'],
          merchantDisplayName: 'Shopping Hub by Aazim',
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              background: Colors.white,
              componentBackground: Colors.grey,
              componentBorder: Colors.black,
              primaryText: Colors.black,
              placeholderText: Colors.black,
              primary: Color(0xff005DFF),
              componentText: Colors.white,
            ),
          ),
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      Get.snackbar(
        "✅ Success",
        "Payment Successful",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "❌ Cancelled",
        "Payment was cancelled.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
