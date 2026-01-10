import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';

class TxtField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  TxtField({
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    super.key,
  });

  @override
  State<TxtField> createState() => _TxtFieldState();
}

class _TxtFieldState extends State<TxtField> {
  bool? _isObscured;

  bool get isObscured => _isObscured ?? widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grayColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              widget.labelText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
          TextField(
            controller: widget.controller,
            obscureText: isObscured,
            decoration: InputDecoration(
              suffixIcon: widget.obscureText
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscured = !isObscured;
                        });
                      },
                      icon: Icon(
                        isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                    )
                  : null,

              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(color: AppColors.grayColor),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
