import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_signin_screens/src/features/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'src/core/theme/app_theme.dart';
import 'src/providers/cart_provider.dart';
import 'src/providers/favorites_provider.dart';
import 'src/providers/user_provider.dart';
import 'src/providers/orders_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()..loadCart()),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider()..loadFavorites(),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()..loadOrders()),
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Premium Auto Shop',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
