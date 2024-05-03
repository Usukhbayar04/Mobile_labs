import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/home.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/login_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Global_provider(),
      child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: SafeArea(
        child: LoginPage(),
      ),
      );
  }
}