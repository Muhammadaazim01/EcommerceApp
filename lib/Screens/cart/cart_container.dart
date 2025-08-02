import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.network(
                imageUrl,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
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
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {
                            cartController.removeItem(index);
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
