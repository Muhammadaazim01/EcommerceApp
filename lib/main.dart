import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/favrouite/controller.dart';

import 'package:ecommerceapp/Screens/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/category_controller.dart';
import 'controllers/product_controller.dart';

void main() {
  Get.put(CategoryController(), permanent: true);
  Get.put(ProductController(), permanent: true);
  Get.put(CartController(), permanent: true);
  Get.put(FavoriteController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
