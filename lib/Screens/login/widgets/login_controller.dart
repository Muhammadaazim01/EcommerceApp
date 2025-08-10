import 'package:ecommerceapp/Widgets/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      // Firebase authentication call
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Agar login successful ho jata hai to home screen pe navigate karo
      Get.off(() => BottomNavBarScreen(initialIndex: 0));

      isLoading.value = false;

      Get.snackbar(
        "Success",
        "Logged in successfully!",
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
      );
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;

      String message = "An error occurred";

      if (e.code == 'user-not-found') {
        message = "No account found with this email.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password.";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email address.";
      }

      Get.snackbar(
        "Login Failed",
        message,
         backgroundColor: Colors.grey[800],
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                margin: EdgeInsets.all(12),
                                borderRadius: 8,
                                duration: Duration(seconds: 2),
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        backgroundColor: Colors.grey[800],
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                margin: EdgeInsets.all(12),
                                borderRadius: 8,
                                duration: Duration(seconds: 2),
      );
    }
  }
}
