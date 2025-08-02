import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/detail_screen.dart';
import 'package:ecommerceapp/Screens/favrouite/controller.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoeCard extends StatefulWidget {
  final Widget imageWidget;
  final String title;
  final String subtitle;
  final String price;
  final ProductModel product;

  const ShoeCard({
    super.key,
    required this.imageWidget,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.product,
  });

  @override
  State<ShoeCard> createState() => _ShoeCardState();
}

final CartController cartController = Get.find<CartController>();
final favoriteController = Get.find<FavoriteController>();

class _ShoeCardState extends State<ShoeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailScreen(productModel: widget.product));
      },
      child: Container(
        width: 240,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: widget.imageWidget, // ✅ FIXED
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 25,
                  child: Obx(() {
                    bool isFav = favoriteController.isFavorite(widget.product);

                    return GestureDetector(
                      onTap: () =>
                          favoriteController.toggleFavorite(widget.product),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border_outlined,
                        color: isFav ? Colors.red : Colors.black,
                        size: 26,
                      ),
                    );
                  }),
                ),
              ],
            ),

            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.subtitle,
                    style: TextStyle(fontSize: 14, color: Color(0xffABA9A9)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.price,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cartController.addToCart(widget.product);
                          Get.snackbar(
                            "Added to Cart",
                            "${widget.product.title} added successfully!",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Add to Cart",
                              style: GoogleFonts.roboto(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
