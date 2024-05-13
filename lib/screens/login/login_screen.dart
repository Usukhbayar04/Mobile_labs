// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:login_signup/widgets/customButton.dart';
import 'package:login_signup/widgets/customTextField.dart';
import '../../utils/sizes/sizes.dart';
import '../../widgets/mTextStyle.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  void _submit() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
    }
  }

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
                'Login',
                style: TextStyle(
                  fontSize: 42,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightMax,
              heightMedium,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    labelText: 'Email',
                    borderRadius: BorderRadius.circular(10.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                  heightMedium,
                  CustomTextField(
                    labelText: 'Password',
                    borderRadius: BorderRadius.circular(10.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value!,
                  ),
                  heightMedium,
                  Text(
                    'Forgor your password',
                    style: meTextStyle(),
                  ),
                  heightMax,
                  CustomButton(
                    onPressed: _submit,
                    text: 'LOGIN',
                  ),
                ],
              ),
              heightMax,
              heightMedium,
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
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Signup',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Text(
                        ' Or login with social account',
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
