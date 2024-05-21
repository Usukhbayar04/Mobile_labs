import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/home.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/repository/repository.dart';

import 'models/cartProduct.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bool _changeButton = false;
  final _formKey = GlobalKey<FormState>();
  final MyRepository repository = MyRepository();

  String _userName = "mor_2314";
  String _userPass = "83r5^_";

  moveToHome(BuildContext context) async {
    try {
      String token = await repository.login(_userName, _userPass);
      Provider.of<Global_provider>(context, listen: false).saveToken(token);
      print(
          'token got : ${await Provider.of<Global_provider>(context, listen: false).getToken()}');

      int userId = await repository.getUserId(_userName);
      var userCartData = await repository.getUserCart(userId);

      List<Cart> userCart = (userCartData as List)
          .map((cartJson) => Cart.fromJson(cartJson))
          .toList();

      Provider.of<Global_provider>(context, listen: false)
          .setCartItems(userCart.first.products!);

      print('User ID : $userId');
      print('User cart:  $userCartData');

      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    } catch (e) {
      print('Error is $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text("Тавтай морил",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 26,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  child: Column(
                    children: [
                      SizedBox(
                        width: true
                            ? 500
                            // ignore: dead_code
                            : MediaQuery.of(context).size.width,
                        child: TextFormField(
                          onChanged: (value) {
                            _userName = value;
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "Нэрээ оруулна уу",
                              label: Text("Нэр:")),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Хоосон байж болохгүй";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: true
                            ? 500
                            // ignore: dead_code
                            : MediaQuery.of(context).size.width,
                        child: TextFormField(
                          onChanged: (value) {
                            _userPass = value;
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Нууц үг оруул",
                            label: Text("Нууц үг"),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Хоосон байж болохгүй";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(32.0),
                        color: Colors.deepPurple,
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () => moveToHome(context),
                          child: AnimatedContainer(
                            color: Colors.transparent,
                            duration: const Duration(seconds: 1),
                            height: 50,
                            width: _changeButton ? 50 : 150,
                            alignment: Alignment.center,
                            child: _changeButton
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Нэвтрэх",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
