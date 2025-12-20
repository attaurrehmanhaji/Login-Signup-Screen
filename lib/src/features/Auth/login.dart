import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';
import 'package:login_signin_screens/src/features/Auth/forget_password.dart';
import 'package:login_signin_screens/src/features/Auth/signin.dart';
import 'package:login_signin_screens/src/features/home/home.dart';
import 'package:login_signin_screens/src/shared/widgets/appButtan.dart';
import 'package:login_signin_screens/src/shared/widgets/noAccount.dart';
import 'package:login_signin_screens/src/shared/widgets/orDdivider.dart';
import 'package:login_signin_screens/src/shared/widgets/social_login.dart';
import 'package:login_signin_screens/src/shared/widgets/textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.orangeColor,
        body: Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,

              child: Text(
                "Welcome back",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 150),
              width: double.infinity,
              height: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
              ),
              child: ListView(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 40),
                    child: Center(
                      child: Text(
                        "LogIn",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TxtField(
                    'Emale',
                    'Login@example.com',
                    false,
                    controller: emailController,
                  ),
                  TxtField(
                    'Password',
                    '*********',
                    true,
                    controller: passwordController,
                  ),

                  AppButtan(
                    btnText: 'Login',

                    onTap: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter email and password'),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPassword(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Forget Password ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  OrDivider(),
                  SocialLogin(),
                  NoAccount(
                    text: "Don't have any account ",
                    linkText: "Sign Up",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
