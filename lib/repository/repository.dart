// import 'package:flutter/foundation.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/services/httpService.dart';

class MyRepository {
  final HttpService httpService = HttpService();

  MyRepository();

  Future<List<ProductModel>> fetchProductData() async {
    try {
      var jsonData = await httpService.getData('products', null);
      // if (kDebugMode) {
      //   print(jsonData);
      // }
      List<ProductModel> data = ProductModel.fromList(jsonData);
      return data;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> login(String username, String password) async {
    try {
      dynamic data = {"username": username, "password": password};
      var jsonData = await httpService.postData('auth/login', null, data);
      return jsonData["token"];
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<int> getUserId(String username) async {
    try {
      var jsonData = await httpService.getData('users', null);
      List<dynamic> users = jsonData;
      for (var user in users) {
        if (user['username'] == username) {
          return user['id'];
        }
      }
      throw Exception('User not found');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<dynamic> getUserCart(int userId) async {
    try {
      var jsonData = await httpService.getData('carts/user/$userId', null);
      return jsonData;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
