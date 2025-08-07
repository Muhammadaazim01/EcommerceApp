import 'package:ecommerceapp/Screens/detail_screen/detail_screen.dart';
import 'package:ecommerceapp/Screens/home/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerceapp/controllers/category_controller.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';

class SearchScreen extends StatefulWidget {
  final CategoryController categoryController;
  final ProductController productController;

  const SearchScreen({
    super.key,
    required this.categoryController,
    required this.productController,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // ✅ Allows layout to adjust with keyboard
      appBar: AppBar(
        title: const Text('Search Products'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by name...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    searchQuery.value = value.toLowerCase().trim();
                  },
                ),
                const SizedBox(height: 8),

                // 🔽 Suggestion list
                Obx(() {
                  if (searchQuery.value.isEmpty) return const SizedBox();
                  final suggestions = widget.productController.productList
                      .where(
                        (p) => (p.title ?? '').toLowerCase().contains(
                          searchQuery.value,
                        ),
                      )
                      .toList();

                  if (suggestions.isEmpty) return const SizedBox();

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: suggestions.length > 4
                          ? 4
                          : suggestions.length, // ✅ Limit to 4
                      itemBuilder: (context, index) {
                        final suggestion = suggestions[index];
                        return ListTile(
                          title: Text(suggestion.title ?? ''),
                          onTap: () {
                            searchController.text = suggestion.title ?? '';
                            searchQuery.value = suggestion.title!.toLowerCase();
                            FocusScope.of(context).unfocus(); // Close keyboard
                          },
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          // 🔽 Search result grid
          Expanded(
            child: Obx(() {
              if (widget.productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final allProducts = widget.productController.productList;
              final filteredProducts = searchQuery.value.isEmpty
                  ? allProducts
                  : allProducts
                        .where(
                          (p) => (p.title ?? '').toLowerCase().contains(
                            searchQuery.value,
                          ),
                        )
                        .toList();

              if (filteredProducts.isEmpty) {
                return const Center(child: Text('No products found.'));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final imageUrl = (product.images?.isNotEmpty ?? false)
                      ? product.images!.first
                      : '';

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailScreen(productModel: product));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: buildProductImage(
                                imageUrl,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.title ?? "No title",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '\$${product.price?.toStringAsFixed(2) ?? "0.00"}',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
