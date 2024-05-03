import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/provider/globalProvider.dart';


// ignore: camel_case_types
class Product_detail extends StatelessWidget {
  final ProductModel product; 
  Product_detail(this.product, {super.key});
  bool inCard =true;
  

  @override
  Widget build(BuildContext context) {
        return Consumer<Global_provider>(
        builder: (context, provider, child) {
        return Scaffold(
            appBar: AppBar(
              title: Semantics(
                      sortKey: const OrdinalSortKey(0),
                      header: true,
                      child: const Text('Product detail'),
                    ),
            ),
            
            body: Column(
              children: [
                Image.network(product.image!,height: 200,),
                Text(product.title!,style:  const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Text(product.description!, style: const TextStyle(fontSize: 16),),
                Text('PRICE: \$${product.price}',style:  const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Text('Rating: ${product.count}',style:  const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
              ],
            ),
            floatingActionButton: FloatingActionButton(onPressed: (){provider.addCartItem(product);}, child: Icon(Icons.shopping_cart))
            );
          } );}
}
