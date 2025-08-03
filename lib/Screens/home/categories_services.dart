import 'dart:convert';

import 'package:ecommerceapp/models/product_model.dart';
import 'package:http/http.dart' as http;

class CategoriesServices {
  Future<List<CategoryModel>> getcategory() async {
    List<CategoryModel> allcategories = [];
    var url = Uri.https("api.escuelajs.co", "/api/v1/categories");
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    for (var i in responseBody) {
      allcategories.add(CategoryModel.fromJson(i));
    }
    return allcategories;
  }
}
