import 'package:flutter/material.dart';
import 'package:login_signup/screens/login/login_screen.dart';
import 'package:login_signup/validations/form_validators.dart';
import '../../utils/sizes/sizes.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/mTextStyle.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      String userMail = _emailController.text;
      String userPass = _passwordController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Successfully! \nYour username: $userMail, \npassword: $userPass',
          ),
        ),
      );
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
            child: Form(
              key: _formKey,
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
                        hintText: 'Email',
                        obscureText: false,
                        controller: _emailController,
                        validator: FormValidators.validateEmail,
                      ),
                      heightMedium,
                      CustomTextField(
                        hintText: 'Password',
                        obscureText: true,
                        controller: _passwordController,
                        validator: FormValidators.validatePassword,
                      ),
                      heightMedium,
                      CustomTextField(
                        hintText: 'Confirm Password',
                        obscureText: true,
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Password do not match';
                          }
                          return null;
                        },
                      ),
                      heightMedium,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
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
                        onPressed: _signup,
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
            )),
      ),
    );
  }
}
