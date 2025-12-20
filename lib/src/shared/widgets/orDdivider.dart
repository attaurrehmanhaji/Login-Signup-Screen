import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Divider(color: Colors.grey, thickness: 2)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'OR',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),

        Expanded(child: Divider(color: Colors.grey, thickness: 2)),
      ],
    );
  }
}
