import 'package:ecommerceapp/Screens/address/address_controller.dart';
import 'package:ecommerceapp/Screens/address/address_screen.dart';
import 'package:ecommerceapp/Screens/address/widgtes/order_info.dart';
import 'package:ecommerceapp/Screens/cart/cart_container.dart';
import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/cart/thankyou_for_shopping.dart';
import 'package:ecommerceapp/Screens/payment_method/payment_card_widget.dart';
import 'package:ecommerceapp/Screens/payment_method/widgets/payment_controller.dart';
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
  final PaymentController paymentController = Get.find<PaymentController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Cart item",
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
              SizedBox(height: 10),
              Text(
                'Order Info',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => OrderInfoWidget(
                  subtotal: '\$${cartController.subtotal.toStringAsFixed(2)}',
                  shippingCost:
                      '\$${cartController.shipping.toStringAsFixed(2)}',
                  total: '\$${cartController.total.toStringAsFixed(2)}',
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
                      // Show full screen loader
                      showGeneralDialog(
                        context: Get.context!,
                        barrierDismissible: false,
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionDuration: Duration(milliseconds: 200),
                        pageBuilder: (_, __, ___) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          );
                        },
                      );

                      await Future.delayed(Duration(seconds: 2));

                      // Remove loader
                      Navigator.of(Get.context!).pop();

                      // Navigate
                      Get.to(() => AddressScreen());
                    },
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),

              Obx(() {
                if (addressController.selectedAddress.value == null) {
                  return GestureDetector(
                    onTap: () {
                      // Future me address select karne ka action yahan daal sakte ho
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_off, color: Colors.grey),
                          SizedBox(width: 10),
                          Text(
                            "No address selected",
                            style: GoogleFonts.montserrat(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final addr = addressController.selectedAddress.value!;
                return GestureDetector(
                  onTap: () {
                    // Tap par same address reselect ho sakta hai ya change hoga
                    addressController.selectedAddress.value = addr;
                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color:
                                addressController.selectedAddress.value == addr
                                ? Colors.green
                                : Colors.grey.shade200,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 28,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    addr.name ?? "",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    addr.description ?? "",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ✅ Green tick
                      if (addressController.selectedAddress.value == addr)
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 22,
                          ),
                        ),
                    ],
                  ),
                );
              }),

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
                cardType: "Card Pay",
                lastDigits: "**** **** **** **90",
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (cartController.cartItems.isEmpty) {
                    Get.snackbar(
                      'Cart is Empty',
                      'Please add items before proceeding to checkout!',
                      backgroundColor: Colors.grey[800],
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(12),
                      borderRadius: 8,
                      duration: Duration(seconds: 2),
                      icon: Icon(Icons.warning, color: Colors.white),
                    );
                    return; // Exit early
                  }

                  if (addressController.selectedAddress.value == null) {
                    Get.snackbar(
                      'Address Missing',
                      'Please fill your address before checkout!',
                      backgroundColor: Colors.grey[800],
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(12),
                      borderRadius: 8,
                      duration: Duration(seconds: 2),
                      icon: Icon(Icons.location_off, color: Colors.white),
                    );
                    return;
                  }

                  if (!paymentController.paymentSuccess.value) {
                    Get.snackbar(
                      'Payment Method',
                      'Please select your payment method!',
                      backgroundColor: Colors.grey[800],
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(12),
                      borderRadius: 8,
                      duration: Duration(seconds: 2),
                      icon: Icon(Icons.payment, color: Colors.white),
                    );
                    return;
                  }

                  // Sab kuch theek hai to loading dikhayein
                  Get.dialog(
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2,
                      ),
                    ),
                    barrierDismissible: false,
                  );

                  // Thoda delay simulate karen (jaise backend payment confirm kar raha ho)
                  await Future.delayed(Duration(seconds: 2));

                  // Loader band karo
                  Get.back();

                  // Navigate to Thank You screen
                  Get.to(() => ThankYouScreen());

                  // Clear the cart
                  cartController.clearcart();
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF512F),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Checkout',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
