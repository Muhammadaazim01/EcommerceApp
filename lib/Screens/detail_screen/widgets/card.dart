import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/detail_screen/widgets/color_dots.dart';
import 'package:ecommerceapp/Screens/detail_screen/widgets/expandable_text.dart';
import 'package:ecommerceapp/Widgets/sized_button.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailCard extends StatefulWidget {
  final String title;
  final String price;
  final String category;
  final double rating;
  final String description;
  final String imageurl;
  final ProductModel productModel;
  final List listsize;
  final Function(String)? sizebuttontap;

  const DetailCard({
    super.key,
    required this.title,
    required this.price,
    required this.category,
    required this.rating,
    required this.description,
    required this.imageurl,
    required this.productModel,
    required this.listsize,
    required this.sizebuttontap,
  });

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '\$${widget.price}',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Rating Row
        Row(
          children: [
            Text(
              widget.category,
              style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(width: 10),
            ...List.generate(
              5,
              (index) => const Icon(Icons.star, color: Colors.yellow, size: 20),
            ),
            const SizedBox(width: 10),
            Text(
              '${widget.rating}',
              style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Colors Row
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
            ColorSelector(),
          ],
        ),

        const SizedBox(height: 20),

        // Size Guide
        Row(
          children: [
            Text(
              "Select a Size",
              style: GoogleFonts.montserrat(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(width: 10),
            Text(
              "(view size guide)",
              style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.listsize.length,
            itemBuilder: (context, index) {
              final size = widget.listsize[index];
              return SizedButton(
                size: size,
                isSelected: selectedSize == size,
                onTap: () {
                  setState(() {
                    selectedSize = size;
                  });
                  widget.sizebuttontap?.call(size);
                },
              );
            },
          ),
        ),

        const SizedBox(height: 20),

        // Description
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
              child: const Text(
                'Details',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        ExpandableText(text: widget.description),

        const SizedBox(height: 20),

        // Add to Cart Button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              final cartController = Get.find<CartController>();
              cartController.addToCart(widget.productModel);

              Get.snackbar(
                "Added to Cart",
                "${widget.productModel.title ?? "Item"} added successfully",
                backgroundColor: Colors.blueGrey,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(60),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              "Add to Cart",
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
