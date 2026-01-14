import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/features/cart/cart_screen.dart';
import 'package:login_signin_screens/src/features/favorites/favorites_screen.dart';
import 'package:login_signin_screens/src/features/home/home.dart';
import 'package:login_signin_screens/src/features/profile/profile_screen.dart';
import 'package:login_signin_screens/src/providers/cart_provider.dart';
import 'package:login_signin_screens/src/shared/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const FavoritesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen to cart provider to update badge count
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
        cartItemCount: cartProvider.itemCount,
      ),
    );
  }
}
