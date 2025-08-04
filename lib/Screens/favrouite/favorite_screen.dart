import 'package:ecommerceapp/Screens/detail_screen/detail_screen.dart'
    show DetailScreen;
import 'package:ecommerceapp/Screens/favrouite/controller.dart';
import 'package:ecommerceapp/Screens/home/widgets/custom_image_widget.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("My Favorites"),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (favoriteController.favoriteItems.isEmpty) {
          return const Center(
            child: Text("No favorite items", style: TextStyle(fontSize: 16)),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: favoriteController.favoriteItems.length,
          itemBuilder: (context, index) {
            final product = favoriteController.favoriteItems[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => DetailScreen(productModel: product));
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: buildProductImage(
                            product.images?.first ?? "",
                            height: 180,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title ?? "No Title",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                product.category?.name ?? "No Category",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.price != null
                                    ? '\$${product.price}'
                                    : "No Price",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: InkWell(
                        onTap: () {
                          favoriteController.toggleFavorite(product);
                          Get.snackbar(
                            "Removed",
                            "${product.title} removed from favorites",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.blueGrey,
                            colorText: Colors.black,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.delete, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
