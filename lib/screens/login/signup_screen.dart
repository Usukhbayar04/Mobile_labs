import 'package:flutter/material.dart';
import 'package:login_signup/screens/login/login_screen.dart';

import '../../utils/sizes/sizes.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/mTextStyle.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final userNameController = TextEditingController();
  final userMailController = TextEditingController();
  final userPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightMedium,
              const Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 42,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightMax,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    hintText: 'Name',
                    obscureText: false,
                    controller: userNameController,
                  ),
                  heightMedium,
                  CustomTextField(
                    hintText: 'Email',
                    obscureText: false,
                    controller: userMailController,
                  ),
                  heightMedium,
                  CustomTextField(
                    hintText: 'Password',
                    obscureText: true,
                    controller: userPassController,
                  ),
                  heightMedium,
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Already have a account?',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  heightMax,
                  CustomButton(
                    onPressed: () {},
                    text: 'SIGN UP',
                  ),
                ],
              ),
              heightMax,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Text(
                        ' Or continue with ',
                        style: meTextStyle(),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  heightMedium,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/google.png'),
                        width: 60,
                        height: 60,
                      ),
                      widthMedium,
                      Image(
                        image: AssetImage('assets/images/facebook.png'),
                        width: 60,
                        height: 60,
                      ),
                    ],
                  ),
                  heightMedium,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
