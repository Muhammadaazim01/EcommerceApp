import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/cart/cart_main.dart';
import 'package:ecommerceapp/Screens/home/card_widget.dart';
import 'package:ecommerceapp/Screens/home/category_controller.dart';
import 'package:ecommerceapp/Widgets/shoe_tabbar.dart';
import 'package:ecommerceapp/Widgets/shoecard_vertcial.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoeHomeScreen extends StatefulWidget {
  const ShoeHomeScreen({super.key});

  @override
  State<ShoeHomeScreen> createState() => _ShoeHomeScreenState();
}

class _ShoeHomeScreenState extends State<ShoeHomeScreen> {
  final ProductController productController = Get.put(ProductController());
  final CategoryController categoryController = Get.put(CategoryController());
  final CartController cartController = Get.put(CartController());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.only(top: 220),
              child: _buildProductBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
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
              const SizedBox(),
              Obx(
                () => Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CartScreen()),
                        );
                      },
                    ),
                    if (cartController.cartItems.isNotEmpty)
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${cartController.cartItems.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "TrendVerse",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Text(
            "Collection",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => categoryController.isLoading.value
                ? const CircularProgressIndicator(color: Colors.white)
                : ShoeTabBar(
                    selectedIndex: categoryController.selectedIndex.value,
                    onTabSelected: (index) =>
                        categoryController.selectCategory(index),
                    tabs: [
                      'Men',
                      ...categoryController.categories
                          .map((c) => c.name ?? '')
                          .toList(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductBody() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHorizontalProducts(),
          const SizedBox(height: 20),
          _buildLatestHeader(),
          const SizedBox(height: 20),
          _buildVerticalProducts(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHorizontalProducts() {
    return SizedBox(
      height: 388,
      child: Obx(() {
        if (productController.isLoading.value ||
            categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final selectedIndex = categoryController.selectedIndex.value;
        final allProducts = productController.productList;

        final filtered = selectedIndex == 0
            ? allProducts
            : allProducts
                  .where(
                    (p) =>
                        p.category?.id ==
                        categoryController.categories[selectedIndex - 1].id,
                  )
                  .toList();

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filtered.length,
          itemBuilder: (_, index) {
            final product = filtered[index];
            return ShoeCard(
              imageWidget:
                  (product.images != null && product.images!.isNotEmpty)
                  ? Image.network(
                      product.images!.first,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _noImageAvailableWidget(),
                    )
                  : _noImageAvailableWidget(),
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

  Widget _buildLatestHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Latest Collection",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              latestScrollController.animateTo(
                latestScrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              );
            },
            child: const Text("Show all", style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalProducts() {
    return SizedBox(
      height: 105,
      child: Obx(() {
        if (productController.isLoading.value ||
            categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final selectedIndex = categoryController.selectedIndex.value;
        final allProducts = productController.productList;

        final filtered = selectedIndex == 0
            ? allProducts
            : allProducts
                  .where(
                    (p) =>
                        p.category?.id ==
                        categoryController.categories[selectedIndex - 1].id,
                  )
                  .toList();

        return ListView.builder(
          controller: latestScrollController,
          scrollDirection: Axis.horizontal,
          itemCount: filtered.length,
          itemBuilder: (_, index) {
            final product = filtered[index];
            return ShoeCardVertcial(imageurl: product.images?.first ?? "");
          },
        );
      }),
    );
  }

  Widget _noImageAvailableWidget() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: const Text(
        "No Image Available",
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
      ),
    );
  }
}
