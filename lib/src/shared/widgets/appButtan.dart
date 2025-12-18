import 'package:flutter/material.dart';

class AppButtan extends StatelessWidget {
  final String btnText;
  const AppButtan({super.key, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      height: 60,
      width: 400,
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
    );
  }
}
