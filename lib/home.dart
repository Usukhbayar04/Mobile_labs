import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/screens/bags.dart';
import 'package:shop_app/screens/favorites.dart';
import 'package:shop_app/screens/profile.dart';
import 'package:shop_app/screens/shopping.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // ignore: non_constant_identifier_names
  List<Widget> Pages = [const ShopPage(), const Basket(), const Favorites(), const Profile()];

  @override
  Widget build(BuildContext context) {
    return  Consumer<Global_provider>(
    builder: (context, provider, child) {
    return Scaffold(
      body: Pages[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: provider.currentIndex,
        onTap: provider.changeCurrentIdx,
        items: 
          const [
            BottomNavigationBarItem(icon: Icon(Icons.shop), label:'Shop'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Basket'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ]),
    );});
} 
}