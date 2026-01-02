import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';
import 'package:login_signin_screens/src/shared/widgets/appButtan.dart';
import 'package:login_signin_screens/src/shared/widgets/textField.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
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
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              ),
            ),
            Center(child: SingleChildScrollView(child: forgetContainer())),
          ],
        ),
      ),
    );
  }

  forgetContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Forget Password!',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select which contact details should we use to reset your password',

                  style: TextStyle(
                    fontSize: 16,
                    // color: Colors.black, // Removed to use default theme color
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                TxtField(
                  'email',
                  'Login@abc.com',
                  false,
                  controller: emailController,
                ),
                AppButtan(btnText: 'Send', onTap: () {}),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
