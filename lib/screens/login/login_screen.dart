import 'package:flutter/material.dart';
import 'package:login_signup/validations/form_validators.dart';
import 'package:login_signup/widgets/customTextField.dart';
import '../../utils/sizes/sizes.dart';
import '../../widgets/customButton.dart';
import '../../widgets/mTextStyle.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _userPassController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _userPassController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      String userName = _userNameController.text;
      String passName = _userPassController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Successfully! \nYour username: $userName, \npassword: $passName',
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
                      controller: _userNameController,
                      hintText: 'Email',
                      obscureText: false,
                      validator: FormValidators.validateEmail,
                    ),
                    heightMedium,
                    CustomTextField(
                      controller: _userPassController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: FormValidators.validatePassword,
                    ),
                    heightMedium,
                    Text(
                      'Forgot your password',
                      style: meTextStyle(),
                    ),
                    heightMax,
                    CustomButton(
                      onPressed: _login,
                      text: 'LOGIN',
                    ),
                  ],
                ),
                heightMedium,
                heightMedium,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Not a member? Register now',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
