import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/detail_screen/detail_screen.dart'
    show DetailScreen;
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
  bool isAdding = false;

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
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: widget.imageWidget,
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
            SizedBox(height: 8), // thoda kam kiya
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
                  SizedBox(height: 6), // thoda kam kiya
                  Text(
                    widget.subtitle,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Color(0xffABA9A9),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4), // thoda kam kiya
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.price,
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      isAdding
                          ? SizedBox(
                              height: 36,
                              width: 100,
                              child: Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                bool alreadyInCart = cartController.cartItems
                                    .any(
                                      (item) => item.id == widget.product.id,
                                    );

                                if (alreadyInCart) {
                                  Get.snackbar(
                                    "Already in Cart",
                                    "${widget.product.title} is already in your cart.",
                                    backgroundColor: Colors.grey[800],
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: EdgeInsets.all(12),
                                    borderRadius: 8,
                                    duration: Duration(seconds: 2),
                                  );
                                  return; // Loader skip
                                }

                                setState(() => isAdding = true);

                                // Fake delay to show loader
                                await Future.delayed(
                                  Duration(milliseconds: 700),
                                );

                                cartController.addToCart(widget.product);

                                setState(() => isAdding = false);
                              },

                              child: Container(
                                height: 36,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF512F),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Add to Cart",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
