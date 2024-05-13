import 'package:flutter/material.dart';
import 'package:login_signup/screens/login/login_screen.dart';

import '../../utils/sizes/sizes.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/mTextStyle.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                    labelText: 'Name',
                    borderRadius: BorderRadius.circular(10.0),
                    onSaved: (value) {},
                  ),
                  heightMedium,
                  CustomTextField(
                    labelText: 'Email',
                    borderRadius: BorderRadius.circular(10.0),
                    onSaved: (value) {},
                  ),
                  heightMedium,
                  CustomTextField(
                    labelText: 'Password',
                    borderRadius: BorderRadius.circular(10.0),
                    onSaved: (value) {},
                  ),
                  heightMedium,
                  Text(
                    'Already have a account?',
                    style: meTextStyle(),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          'Login',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Text(
                        ' Or sign up with social account',
                        style: meTextStyle(),
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
