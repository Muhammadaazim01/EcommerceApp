import 'package:ecommerceapp/Screens/login/login_screen.dart';
import 'package:ecommerceapp/Widgets/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final Rxn<User> firebaseUser = Rxn<User>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    print("✅ AuthController onInit called");

    firebaseUser.bindStream(_auth.authStateChanges());

    ever(firebaseUser, (user) {
      if (user != null) {
        // User is logged in
        Get.offAll(() => BottomNavBarScreen(initialIndex: 0));
      } else {
        // User is logged out
        Get.offAll(() => LoginScreen());
      }
    });
  }

  // Email/Password Login
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }

  // Email/Password Signup
  Future<void> signup(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Signup Failed",
        e.message ?? "An error occurred",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
