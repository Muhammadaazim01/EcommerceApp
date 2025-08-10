import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;
  var quantities = <int>[].obs;

  void addToCart(ProductModel product) {
    bool alreadyInCart = cartItems.any((item) => item.id == product.id);

    if (alreadyInCart) {
      // Snackbar from controller (optional — ya tum UI me handle kar sakte ho)
      Get.snackbar(
        "Already in Cart",
        "${product.title} is already in your cart.",
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
      );
    } else {
      cartItems.add(product);
      quantities.add(1);
      Get.snackbar(
        "Added to Cart",
        "${product.title} added successfully!",
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
      );
    }
  }

  void increaseQuantity(int index) {
    quantities[index]++;
    update(); // notify Order Info widget
  }

  void decreaseQuantity(int index) {
    if (quantities[index] > 1) {
      quantities[index]--;
      update();
    }
  }

  void clearcart() {
    cartItems.clear();
    quantities.clear();
    update();
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
    quantities.removeAt(index);
  }

  double get subtotal {
    double total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      total += (cartItems[i].price ?? 0) * quantities[i];
    }
    return total;
  }

  double get shipping => 10;

  double get total => subtotal + shipping;
}
