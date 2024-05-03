import 'package:flutter/material.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/screens/product_detail.dart';

class ProductViewShop extends StatelessWidget {
  final ProductModel data;

  const ProductViewShop(this.data, {super.key});
  _onTap(BuildContext context ){ Navigator.push(context,MaterialPageRoute(builder: (_)=>Product_detail(data))); }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>{_onTap(context)}, child: Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image
          Container(
            height: 150.0, // Adjust the height based on your design
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.image!),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          // Product details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '\$${data.price!}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
    
    
    // Row(
    //   children: [
    //     Box(
    //       height: width /3,
    //       width: width,
    //       margin: EdgeInsets.only(right: 10),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //         image: DecorationImage(image: NetworkImage(data.image!), fit: BoxFit.fitHeight)
    //       ),
    //     ),
    //      Column(
    //       children: [
    //         Text(data.title==null?"": data.title!),
    //         Text(data.category==null?"": data.category!),
    //         Text('${data.price}'),
    //       ],
    //     )
      
    //   ],
    // );
  }
}