import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/services/product_services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await ProductServices().getproducts();
      productList.assignAll(products);
      print("Fetched Products: ${products.length}");
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading(false);
    }
  }
}
