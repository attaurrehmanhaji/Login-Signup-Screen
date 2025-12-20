import 'package:flutter/material.dart';

class NoAccount extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;
  const NoAccount({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: TextStyle(fontSize: 17)),
        GestureDetector(
          onTap: onTap,
          child: Text(
            linkText,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
            ),
          ),
        ),
      ],
    );
  }
}
