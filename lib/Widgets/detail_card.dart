import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/Widgets/sized_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String price;
  final String category;
  final double rating;
  final String description;
  final String imageurl;
  final ProductModel productModel;

  const DetailCard({
    super.key,
    required this.title,
    required this.price,
    required this.category,
    required this.rating,
    required this.description,
    required this.imageurl,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '\$$price',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  category,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,

                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 10),
                ...List.generate(
                  5,
                  (index) => Icon(Icons.star, color: Colors.yellow, size: 20),
                ),
                SizedBox(width: 10),
                Text(
                  '$rating',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,

                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Colors',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadiusGeometry.circular(20),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadiusGeometry.circular(20),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Select a Size",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "(view size guide)",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedButton(size: '38'),
                SizedButton(size: '39'),
                SizedButton(size: '40', isSelected: true),
                SizedButton(size: '41'),
                SizedButton(size: '42'),
                SizedButton(size: '50'),
              ],
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Details',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),

                      Text(
                        description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                final cartController = Get.find<CartController>();
                cartController.addToCart(productModel);

                Get.snackbar(
                  "Added to Cart",
                  "${productModel.title ?? "Item"} added successfully",
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              },

              style: ElevatedButton.styleFrom(
                minimumSize: Size(376, 80),
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                "Add to Cart",
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
