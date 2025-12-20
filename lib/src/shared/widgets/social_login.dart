import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Color(0xFFFFEBDB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/google.png'),
            ),
          ),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Color(0xFFFFEBDB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/twitter.png'),
            ),
          ),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: AppColors.lightOrangeColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/facebook.png'),
            ),
          ),
        ],
      ),
    );
  }
}
