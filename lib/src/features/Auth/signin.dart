import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';
import 'package:login_signin_screens/src/features/Auth/login.dart';
import 'package:login_signin_screens/src/features/main_navigation/main_navigation_screen.dart';

import 'package:login_signin_screens/src/shared/widgets/appButtan.dart';
import 'package:login_signin_screens/src/shared/widgets/noAccount.dart';
import 'package:login_signin_screens/src/shared/widgets/orDdivider.dart';
import 'package:login_signin_screens/src/shared/widgets/social_login.dart';
import 'package:login_signin_screens/src/shared/widgets/textField.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orangeColor,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              "Welcome",
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
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
            ),
            child: ListView(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 25),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TxtField(
                  labelText: 'First Name',
                  hintText: 'Muhammad',
                  obscureText: false,
                  controller: firstNameController,
                ),
                TxtField(
                  labelText: 'Last Name',
                  hintText: 'Ali',
                  obscureText: false,
                  controller: lastNameController,
                ),
                TxtField(
                  labelText: 'Email',
                  hintText: 'Login@abc.com',
                  obscureText: false,
                  controller: emailController,
                ),
                TxtField(
                  labelText: 'Password',
                  hintText: '*********',
                  obscureText: true,
                  controller: passwordController,
                ),
                TxtField(
                  labelText: 'Confirm Password',
                  hintText: '*********',
                  obscureText: true,
                  controller: confirmPasswordController,
                ),
                AppButtan(
                  btnText: 'Sign Up',
                  onTap: () {
                    print('Sign Up');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainNavigationScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                OrDivider(),
                SocialLogin(),
                NoAccount(
                  text: 'Have an account ',
                  linkText: 'Login',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
