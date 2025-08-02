// lib/Screens/favrouite/favorite_controller.dart
import 'package:get/get.dart';
import 'package:ecommerceapp/models/product_model.dart';

class FavoriteController extends GetxController {
  var favoriteItems = <ProductModel>[].obs;

  void toggleFavorite(ProductModel product) {
    if (favoriteItems.contains(product)) {
      favoriteItems.remove(product);
    } else {
      favoriteItems.add(product);
    }
  }

  bool isFavorite(ProductModel product) {
    return favoriteItems.contains(product);
  }
}
