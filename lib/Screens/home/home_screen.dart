import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/home/widgets/horizontal_product.dart';
import 'package:ecommerceapp/controllers/category_controller.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoeHomeScreen extends StatefulWidget {
  const ShoeHomeScreen({super.key});

  @override
  State<ShoeHomeScreen> createState() => _ShoeHomeScreenState();
}

class _ShoeHomeScreenState extends State<ShoeHomeScreen> {
  final ProductController productController = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();
  final CategoryController categoryController = Get.find<CategoryController>();

  late ScrollController latestScrollController;

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

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(() {
          if (categoryController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 220),
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
    );
  }
}
