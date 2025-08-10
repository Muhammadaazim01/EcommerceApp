import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/home/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String brand;
  final String price;
  final int index;

  CartItemWidget({
    required this.imageUrl,
    required this.name,
    required this.brand,
    required this.price,
    required this.index,
  });

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              /// ✅ Use reusable image widget here
              buildProductImage(imageUrl, width: 100, height: 150),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      brand,
                      style: GoogleFonts.montserrat(color: Colors.grey),
                    ),
                    Text(price, style: GoogleFonts.montserrat(fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                cartController.decreaseQuantity(index);
                              },
                            ),
                            Text('${cartController.quantities[index]}'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                cartController.increaseQuantity(index);
                              },
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Get.dialog(
                              Dialog(
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFF512F), // Bright Orange
                                        Color(0xFFF09819),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "Remove Item",
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Are you sure you want to remove in cart?",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black54,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(
                                                0xFFFF512F,
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.back(); // Just close
                                            },
                                            child: Text(
                                              "No",

                                              style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(
                                                0xFFFF512F,
                                              ),
                                            ),
                                            onPressed: () {
                                              cartController.removeItem(
                                                index,
                                              ); // Item remove
                                              Get.back();

                                              Get.snackbar(
                                                "Removed",
                                                "Item removed from cart",
                                                backgroundColor:
                                                    Colors.grey[800],
                                                colorText: Colors.white,
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                margin: EdgeInsets.all(12),
                                                borderRadius: 8,
                                                duration: Duration(seconds: 2),
                                              );
                                            },
                                            child: Text(
                                              "Yes",
                                              style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
