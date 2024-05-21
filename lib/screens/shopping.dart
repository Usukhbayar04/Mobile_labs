import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/repository/repository.dart';
import 'package:shop_app/widgets/ProductView.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  MyRepository repository = MyRepository();

  Future<List<ProductModel>?> _getProductData() async {
    Global_provider provider =
        Provider.of<Global_provider>(context, listen: false);
    if (provider.products.isEmpty) {
      List<ProductModel> data = await repository.fetchProductData();
      provider.setProducts(data);
      return data;
    } else {
      return provider.products;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getProductData(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Products".tr(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(223, 37, 37, 37),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: List.generate(
                      snapshot.data!.length,
                      (index) => ProductViewShop(snapshot.data![index]),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        } else {
          return const Center(
            child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(),
            ),
          );
        }
      }),
    );
  }
}
