import 'package:ecommerceapp/Screens/detail_screen/detail_screen.dart';
import 'package:ecommerceapp/Screens/home/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerceapp/controllers/category_controller.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  final CategoryController categoryController;
  final ProductController productController;

  SearchScreen({
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
        title: Text(
          "Search items",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF512F), // Bright Orange
                Color(0xFFF09819), //ght Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, // <-- yahan apna custom color do
          size: 28, // optional size change
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100, // light background
                    hintText: 'Search products...',
                    hintStyle: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                      size: 24,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Color(0xFFFF512F),
                        width: 1.5,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      onPressed: () {
                        searchController.clear();
                        searchQuery.value = "";
                      },
                    ),
                  ),
                  onChanged: (value) {
                    searchQuery.value = value.toLowerCase().trim();
                  },
                ),

                SizedBox(height: 8),

                // 🔽 Suggestion list
                Obx(() {
                  if (searchQuery.value.isEmpty) return SizedBox();
                  final suggestions = widget.productController.productList
                      .where(
                        (p) => (p.title ?? '').toLowerCase().contains(
                          searchQuery.value,
                        ),
                      )
                      .toList();

                  if (suggestions.isEmpty) return SizedBox();

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    strokeWidth: 2,
                  ),
                );
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
                return Center(child: Text('No products found.'));
              }

              return GridView.builder(
                padding: EdgeInsets.all(12),
                itemCount: filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      padding: EdgeInsets.all(8),
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
                          SizedBox(height: 8),
                          Text(
                            product.title ?? "No title",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '\$${product.price?.toStringAsFixed(2) ?? "0.00"}',
                            style: GoogleFonts.montserrat(color: Colors.green),
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
