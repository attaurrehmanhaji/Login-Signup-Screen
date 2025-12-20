import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';

class TxtField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const TxtField(
    this.labelText,
    this.hintText,
    this.obscureText, {
    super.key,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grayColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              labelText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: AppColors.grayColor),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
