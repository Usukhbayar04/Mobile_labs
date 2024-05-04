import 'dart:convert';

import 'package:shop_app/models/products.dart';
import 'package:shop_app/services/httpService.dart';


class MyRepository {
  final HttpService httpService=HttpService();

  MyRepository();
  Future<List<ProductModel>> fetchProductData() async {
    try {
      var jsonData = await httpService.getData('products',null);
      print(jsonData);
      List<ProductModel> data = ProductModel.fromList(jsonData);
      return data;
        } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }

   Future<String> login(String username, String password) async {
    try {
      dynamic data = {"username": username, "password": password};
      var jsonData = await httpService.postData('auth/login',null, data);
      return jsonData["token"];
    } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }
}
