import 'package:ecommerceapp/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;
  var quantities = <int>[].obs;

  void addToCart(ProductModel product) {
    cartItems.add(product);
    quantities.add(1);
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
