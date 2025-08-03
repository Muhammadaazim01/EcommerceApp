import 'package:ecommerceapp/Screens/home/categories_services.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categories = <CategoryModel>[].obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      var result = await CategoriesServices().getcategory();

      // Show only specific categories
      final allowed = [
        'Clothes',
        'Electronics',
        'Furniture',
        'Shoes',
        'Miscellaneous',
      ];
      final filtered = result.where((c) => allowed.contains(c.name)).toList();
      categories.assignAll(filtered);
    } finally {
      isLoading(false);
    }
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
  }
}
