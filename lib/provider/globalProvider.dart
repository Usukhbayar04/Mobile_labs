import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_app/models/products.dart';

class Global_provider extends ChangeNotifier{
  List<ProductModel> products =[];
  List<ProductModel> cartItems = [];
  List<ProductModel> favoriteItems = [];
  int currentIndex = 0;
  String? token = "";

  
  void setProduts(List<ProductModel> data){
    products = data;
    notifyListeners();
  }

  void addCartItem(ProductModel data){
    if(cartItems.any((e) => e.id==data.id))
      cartItems.removeWhere((e)=>e.id == data.id);
    else
      cartItems.add(data);
    notifyListeners();
  }

  void removeCartItem(ProductModel data){
    cartItems.removeWhere((e)=>e.id == data.id);
    notifyListeners();
  }
  
  void changeCurrentIdx(int idx){
    currentIndex = idx;
    notifyListeners();
  }

  // Save token
  //flutter pub add flutter_secure_storage
  Future<void> saveToken(String token) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: token);
  }

  // Retrieve token
  Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
}
  
}