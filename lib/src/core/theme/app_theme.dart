import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.orangeColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.orangeColor,
      secondary: AppColors.orangeColor,
      surface: Colors.white,
      onSurface: Colors.black, // Used for text on surface
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.orangeColor,
    scaffoldBackgroundColor: Colors.black, // Or a dark grey
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.orangeColor,
      secondary: AppColors.orangeColor,
      surface: Colors.grey[900]!,
      onSurface: Colors.white, // Used for text on surface
    ),
  );
}
