import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_app/models/products.dart';
import '../models/cartProduct.dart';
import 'package:http/http.dart' as http;

class Global_provider extends ChangeNotifier {
  List<ProductModel> products = [];
  List<ProductModel> cartItems = [];
  List<ProductModel> favoriteItems = [];
  int currentIndex = 0;
  String? token = "";

  Locale _currentLocale = const Locale('en', 'US');
  Locale get currentLocale => _currentLocale;

  void setLocale(Locale newLocale) {
    if (newLocale != _currentLocale) {
      _currentLocale = newLocale;
      notifyListeners();
    }
  }

  void setProducts(List<ProductModel> data) {
    products = data;
    notifyListeners();
  }

  void setCartItems(List<CartProduct> cartProducts) {
    cartItems = cartProducts.map((cartProduct) {
      ProductModel product = products.firstWhere(
        (product) => product.id == cartProduct.productId,
        orElse: () => ProductModel(
          id: cartProduct.productId,
          title: 'Unknown',
          price: 0,
          count: cartProduct.quantity ?? 0,
        ),
      );
      product.count = cartProduct.quantity ?? 1;
      return product;
    }).toList();
    notifyListeners();
  }

  void addCartItem(ProductModel data) {
    if (cartItems.any((e) => e.id == data.id)) {
      cartItems.removeWhere((e) => e.id == data.id);
    } else {
      cartItems.add(data);
    }
    notifyListeners();
  }

  void removeCartItem(ProductModel data) {
    cartItems.removeWhere((e) => e.id == data.id);
    notifyListeners();
  }

  void incrementCount(ProductModel item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (index != -1) {
      cartItems[index].count++;
      notifyListeners();
    }
  }

  void decrementCount(ProductModel item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (index != -1) {
      cartItems[index].count--;
      notifyListeners();
    }
  }

  void setFavorite(ProductModel item) {
    int index = products.indexWhere((product) => product.id == item.id);

    if (index != -1) {
      products[index].isFavorite = !products[index].isFavorite;
      int favIndex =
          favoriteItems.indexWhere((favItem) => favItem.id == item.id);

      if (favIndex == -1 && products[index].isFavorite) {
        favoriteItems.add(products[index]);
      } else if (favIndex != -1 && !products[index].isFavorite) {
        favoriteItems.removeAt(favIndex);
      }

      notifyListeners();
    }
  }

  void changeCurrentIdx(int idx) {
    currentIndex = idx;
    notifyListeners();
  }

  // Save token
  Future<void> saveToken(String token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: token);
  }

  // Retrieve token
  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  // Add
  Future<void> addToServerCart(ProductModel item) async {
    try {
      final token = await getToken();
      if (token != null) {
        final response = await http.post(
          Uri.parse('https://fakestoreapi.com/carts'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode({'productId': item.id}),
        );

        if (response.statusCode == 200) {
          print('Item added to server cart');
        } else {
          throw Exception('Failed to add item to server cart');
        }
      } else {
        throw Exception('Token not available');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  // Remove
  Future<void> removeFromServerCart(ProductModel item) async {
    try {
      final token = await getToken();
      if (token != null) {
        final response = await http.delete(
          Uri.parse('https://fakestoreapi.com/carts/${item.id}'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          print('Item removed from server cart');
        } else {
          throw Exception('Failed to remove item from server cart');
        }
      } else {
        throw Exception('Token not available');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
