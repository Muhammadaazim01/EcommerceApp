import 'package:ecommerceapp/Screens/payment_method/widgets/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class PaymentController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool paymentSuccess = false.obs; // <-- naya observable for success

  final String amount = "5";

  void makePayment() async {
    isLoading.value = true;
    paymentSuccess.value = false; // Reset before payment

    try {
      final paymentIntentData = await PaymentService.createPaymentIntent(
        amount: amount,
      );

      final clientSecret = paymentIntentData['clientSecret'];

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

      await Stripe.instance.presentPaymentSheet();

      paymentSuccess.value = true; // <-- Success hua

      Get.snackbar(
        "✅ Payment Successful",
        "Your payment was successful.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.black,
      );
    } catch (e) {
      Get.snackbar(
        "❌ Payment Failed",
        "Please add a card",
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
