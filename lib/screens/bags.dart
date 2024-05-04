import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/provider/globalProvider.dart'; 

class Basket extends StatelessWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Global_provider>(builder: (context, provider, child) {
      double total = provider.cartItems
          .fold(0, (sum, item) => sum + (item.price! * item.count));
      return Scaffold(
        appBar: AppBar(
          title: Text('cart'),
        ),
        body: provider.cartItems.isEmpty
            ? const Center(
                child: Text(
                  "Cart Is Empty.",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: provider.cartItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.0,
                      ),
                    ),
                    child: Dismissible(
                      // margin: const EdgeInsets.all(8.0),
                      background: Container(
                        color: Colors.red,
                      ),
                      key: ValueKey<ProductModel>(provider.cartItems[index]),
                      onDismissed: (DismissDirection direction) {
                        provider.removeCartItem(provider.cartItems[index]);
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        leading: Image.network(
                          provider.cartItems[index].image!,
                          width: 50, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                        ),
                        title: Text(provider.cartItems[index].title!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        if (provider.cartItems[index].count >
                                            1) {
                                          provider.decrementCount(
                                              provider.cartItems[index]);
                                        } else if (provider
                                                .cartItems[index].count ==
                                            1) {
                                          provider.removeCartItem(
                                              provider.cartItems[index]);
                                          //notifier
                                        }
                                      },
                                    ),
                                    Text(
                                      '${provider.cartItems[index].count}',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        provider.incrementCount(
                                            provider.cartItems[index]);
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  '\$${provider.cartItems[index].price} x ${provider.cartItems[index].count}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${'total'}: \$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement buy all logic
                  // For example, you might want to navigate to a checkout page
                  // or display a confirmation dialog.
                },
                child: Text('buy'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
