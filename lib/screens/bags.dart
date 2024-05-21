import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/provider/globalProvider.dart';

class Basket extends StatelessWidget {
  const Basket({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Global_provider>(builder: (context, provider, child) {
      if (provider.cartItems.isEmpty) {
        return const Center(
          child: Text(
            "Cart Is Empty.",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        );
      }

      double total = provider.cartItems
          .fold(0, (sum, item) => sum + (item.price! * item.count));

      return Scaffold(
        appBar: AppBar(
          title: const Text('cart'),
        ),
        body: ListView.builder(
          itemCount: provider.cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = provider.cartItems[index];
            return Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 1.0,
                ),
              ),
              child: Dismissible(
                background: Container(
                  color: Colors.red,
                ),
                key: ValueKey<ProductModel>(cartItem),
                onDismissed: (DismissDirection direction) {
                  provider.removeCartItem(cartItem);
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: cartItem.image != null
                      ? Image.network(
                          cartItem.image!,
                          width: 50,
                          height: 50,
                        )
                      : const SizedBox(width: 50, height: 50),
                  title: Text(cartItem.title ?? ''),
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
                                  if (cartItem.count > 1) {
                                    provider.decrementCount(cartItem);
                                  } else if (cartItem.count == 1) {
                                    provider.removeCartItem(cartItem);
                                  }
                                },
                              ),
                              Text('${cartItem.count}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  provider.incrementCount(cartItem);
                                },
                              ),
                            ],
                          ),
                          Text(
                            '\$${cartItem.price ?? 0} x ${cartItem.count}',
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
                'Total: \$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    for (final item in provider.cartItems) {
                      await provider.addToServerCart(item);
                    }
                    provider.cartItems.clear();
                    provider.notifyListeners();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Items bought successfully'),
                    ));
                  } catch (e) {
                    print('Error while buying items: $e');
                  }
                },
                child: const Text('Buy'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
