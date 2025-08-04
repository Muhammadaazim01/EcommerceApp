import 'dart:convert';
import 'package:ecommerceapp/models/category_model.dart'; // ✅ FIXED
import 'package:http/http.dart' as http;

class CategoryServices {
  Future<List<CategoryModel>> getcategories() async {
    List<CategoryModel> allcategories = [];
    var url = Uri.https("api.escuelajs.co", "/api/v1/categories");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      for (var i in responseBody) {
        allcategories.add(CategoryModel.fromJson(i));
      }
    } else {
      throw Exception('Failed to fetch categories');
    }

    return allcategories;
  }
}
