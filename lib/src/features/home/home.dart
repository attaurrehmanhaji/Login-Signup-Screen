import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.whiteColor);
  }
}
