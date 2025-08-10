import 'package:ecommerceapp/Screens/cart/cart_controller.dart';

import 'package:ecommerceapp/Screens/favrouite/controller.dart';
import 'package:ecommerceapp/Screens/login/widgets/login_controller.dart';
import 'package:ecommerceapp/Screens/login/widgets/sign_in_controller.dart';
import 'package:ecommerceapp/Screens/payment_method/api_keys.dart';
import 'package:ecommerceapp/Screens/payment_method/widgets/payment_controller.dart';
import 'package:ecommerceapp/Screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'controllers/category_controller.dart';
import 'controllers/product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = StripeKeys.publishableKey;

  Get.put(CategoryController(), permanent: true);
  Get.put(ProductController(), permanent: true);
  Get.put(CartController(), permanent: true);
  Get.put(FavoriteController(), permanent: true);
  Get.put(PaymentController(), permanent: true);
  Get.put(LoginController(), permanent: true);
  Get.put(SignUpController(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: false),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
