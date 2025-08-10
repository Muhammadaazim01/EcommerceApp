import 'package:ecommerceapp/Screens/login/login_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxString userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserName();
  }

  void _loadUserName() {
    final user = _auth.currentUser;
    if (user != null) {
      userName.value = user.displayName ?? 'Guest';
    }
  }

  Future<void> signUp(String email, String password, String userName) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(userName);
      await userCredential.user?.reload();

      this.userName.value = userName;

      Get.snackbar(
        "Success",
        "Account created successfully!",
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
      );

      Get.offAll(() => LoginScreen());
    } catch (e) {
      // handle errors
    }
  }
}
