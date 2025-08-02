import 'dart:convert';

import 'package:ecommerceapp/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  Future<List<ProductModel>> getproducts() async {
    List<ProductModel> allalbums = [];
    var url = Uri.https("api.escuelajs.co", "/api/v1/products");
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    for (var i in responseBody) {
      allalbums.add(ProductModel.fromJson(i));
    }
    return allalbums;
  }
}
