import 'package:ecommerceapp/Screens/address/address_card_widget.dart';
import 'package:ecommerceapp/Screens/address/address_controller.dart';
import 'package:ecommerceapp/Screens/address/address_screen.dart';
import 'package:ecommerceapp/Screens/address/order_info.dart';
import 'package:ecommerceapp/Screens/cart/cart_container.dart';
import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/cart/thankyou_for_shopping.dart';
import 'package:ecommerceapp/Screens/payment_method/payment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.find<CartController>();
  final addressController = Get.put(AddressController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cart',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xff005DFF),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartController.cartItems[index];
                      return CartItemWidget(
                        imageUrl: product.images?.first ?? '',
                        name: product.title ?? '',
                        brand: product.category?.name ?? 'No Brand',
                        price:
                            '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',

                        index: index,
                      );
                    },
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Address',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      Get.defaultDialog(
                        title: "Waiting",
                        titleStyle: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: Color(0xff005DFF),
                        content: CircularProgressIndicator(),
                        barrierDismissible: false,
                      );
                      await Future.delayed(Duration(seconds: 2));
                      Get.back();
                      Get.to(() => AddressScreen());
                    },
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: addressController.addressList.length,
                  itemBuilder: (context, index) {
                    final address = addressController.addressList[index];
                    return AddressCardWidget(
                      name: address.name ?? 'No Name',
                      description: address.description ?? 'No Description',
                      id: address.id!,
                    );
                  },
                ),
              ),

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Method',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              PaymentCardWidget(
                cardType: 'Visa Classic',
                lastDigits: '**** 7690',
              ),
              SizedBox(height: 10),
              Text(
                'Order Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Obx(
                () => OrderInfoWidget(
                  subtotal: '\$${cartController.subtotal.toStringAsFixed(2)}',
                  shippingCost:
                      '\$${cartController.shipping.toStringAsFixed(2)}',
                  total: '\$${cartController.total.toStringAsFixed(2)}',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (cartController.cartItems.isEmpty) {
                    Get.snackbar(
                      'Cart is Empty',
                      'Please add items before proceeding to checkout!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Color(0xff005DFF),
                      colorText: Colors.white,
                      margin: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      borderRadius: 12,
                      duration: Duration(seconds: 3),
                      icon: Icon(Icons.warning, color: Colors.white),
                    );
                  } else {
                    // Show loading dialog
                    Get.dialog(
                      Center(child: CircularProgressIndicator()),
                      barrierDismissible: false,
                    );

                    // Simulate processing delay
                    await Future.delayed(Duration(seconds: 2));

                    // Close the loading dialog
                    Get.back();

                    // Navigate to Thank You screen
                    Get.to(() => ThankYouScreen());

                    // Clear the cart
                    cartController.clearcart();
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff005DFF),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Checkout', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
