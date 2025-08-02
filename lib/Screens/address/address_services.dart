import 'dart:convert';

import 'package:ecommerceapp/Screens/address/address_model.dart';
import 'package:http/http.dart' as http;

class AddressServices {
  Future<List<AddressModel>> getAddress() async {
    List<AddressModel> alladdress = [];
    var url = Uri.https("api.escuelajs.co", "/api/v1/locations");
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    for (var i in responseBody) {
      alladdress.add(AddressModel.fromJson(i));
    }
    return alladdress;
  }
}
