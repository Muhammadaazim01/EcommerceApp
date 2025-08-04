import 'package:get/get.dart';
import 'package:ecommerceapp/models/category_model.dart';
import 'package:ecommerceapp/services/category_services.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoryList = <CategoryModel>[].obs;
  var hasFetched = false.obs; // ✅ Prevent repeated fetching

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    // Even if hasFetched is true, re-fetch if categoryList is empty
    if (hasFetched.value && categoryList.isNotEmpty) {
      print("✅ Categories already fetched. Skipping fetch...");
      return;
    }

    try {
      isLoading.value = true;
      print("🔄 Fetching categories...");

      var categories = await CategoryServices().getcategories();

      categoryList.assignAll(categories);
      print("✅ Fetched ${categories.length} categories");

      hasFetched.value = true;
    } catch (e) {
      print("❌ Error fetching categories: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
