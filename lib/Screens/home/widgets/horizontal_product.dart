import 'package:ecommerceapp/Screens/cart/cart_main.dart';
import 'package:ecommerceapp/Screens/home/widgets/card.dart';
import 'package:ecommerceapp/Screens/home/widgets/custom_image_widget.dart';
import 'package:ecommerceapp/Screens/home/widgets/headers.dart';
import 'package:ecommerceapp/Screens/home/widgets/small_card.dart';
import 'package:ecommerceapp/Screens/home/widgets/tabbar.dart' show ShoeTabBar;
import 'package:ecommerceapp/controllers/category_controller.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildHeader({
  required BuildContext context,
  required CategoryController categoryController,
  required int selectedIndex,
  required dynamic Function(int) onTabSelected,
}) {
  return Container(
    height: 250,
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xff000000), Color(0xff005DFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Obx(
              () => Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.to(() => const CartScreen());
                    },
                  ),
                  if (cartController.cartItems.isNotEmpty)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cartController.cartItems.length}',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "TrendVerse",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          "Collection",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Obx(() {
          final tabs = categoryController.categoryList
              .map((c) => c.name ?? '')
              .toList();
          return ShoeTabBar(
            selectedIndex: selectedIndex,
            onTabSelected: onTabSelected,
            tabs: tabs,
          );
        }),
      ],
    ),
  );
}

Widget buildProductBody(
  int selectedIndex,
  ProductController productController,
  CategoryController categoryController,
  ScrollController latestScrollController,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildHorizontalProducts(
        categoryController: categoryController,
        productController: productController,
        selectedIndex: selectedIndex,
      ),
      SizedBox(height: 20),
      buildLatestHeader(latestScrollController),
      SizedBox(height: 20),
      buildVerticalProducts(
        categoryController,
        productController,
        latestScrollController,
        selectedIndex,
      ),
      SizedBox(height: 20),
    ],
  );
}

Widget buildHorizontalProducts({
  required CategoryController categoryController,
  required ProductController productController,
  required int selectedIndex,
}) {
  return SizedBox(
    height: 388,
    child: Obx(() {
      final selectedCategory = categoryController.categoryList.isNotEmpty
          ? categoryController.categoryList[selectedIndex]
          : null;
      final products = selectedCategory != null
          ? productController.productList
                .where((product) => product.category?.id == selectedCategory.id)
                .toList()
          : [];

      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];
          return ShoeCard(
            imageWidget: buildProductImage(
              product.images?.first ?? '',
              width: double.infinity,
              height: 200,
            ),
            title: product.title ?? "No Title",
            subtitle: product.category?.name ?? "No Category",
            price: product.price != null ? '\$${product.price}' : 'No Price',
            product: product,
          );
        },
      );
    }),
  );
}

Widget buildVerticalProducts(
  CategoryController categoryController,
  ProductController productController,
  ScrollController latestScrollController,
  int selectedIndex,
) {
  return SizedBox(
    height: 105,
    child: Obx(() {
      final selectedCategory = categoryController.categoryList.isNotEmpty
          ? categoryController.categoryList[selectedIndex]
          : null;
      final products = selectedCategory != null
          ? productController.productList
                .where((product) => product.category?.id == selectedCategory.id)
                .toList()
          : [];

      return ListView.builder(
        controller: latestScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];
          return ShoeCardVertcial(
            imageWidget: buildProductImage(
              product.images?.first ?? '',
              width: 100,
              height: 100,
            ),
          );
        },
      );
    }),
  );
}
