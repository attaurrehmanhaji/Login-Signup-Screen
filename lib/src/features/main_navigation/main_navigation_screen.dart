import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/features/cart/cart_screen.dart';
import 'package:login_signin_screens/src/features/favorites/favorites_screen.dart';
import 'package:login_signin_screens/src/features/home/home.dart';
import 'package:login_signin_screens/src/features/profile/profile_screen.dart';
import 'package:login_signin_screens/src/providers/cart_provider.dart';
import 'package:login_signin_screens/src/providers/navigation_provider.dart';
import 'package:login_signin_screens/src/shared/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  void _onItemTapped(int index) {
    Provider.of<NavigationProvider>(
      context,
      listen: false,
    ).setSelectedIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    // Listen to providers to update state
    final cartProvider = Provider.of<CartProvider>(context);
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: IndexedStack(
        index: navigationProvider.selectedIndex,
        children: const [
          Home(),
          FavoritesScreen(),
          CartScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: navigationProvider.selectedIndex,
        onItemSelected: _onItemTapped,
        cartItemCount: cartProvider.itemCount,
      ),
    );
  }
}
