import 'package:flutter/material.dart';

class AppButtan extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  const AppButtan({super.key, required this.btnText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFF8040),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
