import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/home/widgets/horizontal_product.dart';
import 'package:ecommerceapp/Screens/login/login_screen.dart';
import 'package:ecommerceapp/Screens/login/widgets/sign_in_controller.dart';
import 'package:ecommerceapp/controllers/category_controller.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShoeHomeScreen extends StatefulWidget {
  const ShoeHomeScreen({super.key});

  @override
  State<ShoeHomeScreen> createState() => _ShoeHomeScreenState();
}

class _ShoeHomeScreenState extends State<ShoeHomeScreen> {
  final ProductController productController = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();
  final CategoryController categoryController = Get.find<CategoryController>();
  final SignUpController signUpController = Get.find<SignUpController>();

  late ScrollController latestScrollController;

  int selectedIndex = 0;
  bool isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    latestScrollController = ScrollController();
  }

  @override
  void dispose() {
    latestScrollController.dispose();
    super.dispose();
  }

  Future<void> logoutUser() async {
    setState(() => isLoggingOut = true);

    try {
      await FirebaseAuth.instance.signOut();

      // Loader hide mat karo — navigation ke baad screen change ho jayegi
      await Future.delayed(const Duration(milliseconds: 300));

      Get.offAll(() => const LoginScreen()); // Direct widget navigation
    } catch (e) {
      debugPrint("Logout Error: $e");
      setState(() => isLoggingOut = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Obx(() {
              if (categoryController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    strokeWidth: 2,
                  ),
                );
              }
              return Stack(
                children: [
                  buildHeader(
                    context: context,
                    categoryController: categoryController,
                    selectedIndex: selectedIndex,
                    onTabSelected: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    signUpController: signUpController,
                    onLogoutPressed: logoutUser, // 👈 new callback
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 220),
                    child: buildProductBody(
                      selectedIndex,
                      productController,
                      categoryController,
                      latestScrollController,
                    ),
                  ),
                ],
              );
            }),
          ),

          // 🔹 Full-screen overlay loader on logout
          if (isLoggingOut)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
