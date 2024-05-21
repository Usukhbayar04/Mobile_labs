class CartProduct {
  int? productId;
  int? quantity;

  CartProduct({this.productId, this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}

class Cart {
  int? id;
  int? userId;
  String? date;
  List<CartProduct>? products;

  Cart({this.id, this.userId, this.date, this.products});

  factory Cart.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    List<CartProduct> productsList =
        list.map((i) => CartProduct.fromJson(i)).toList();

    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: productsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'products': products?.map((e) => e.toJson()).toList(),
    };
  }
}
