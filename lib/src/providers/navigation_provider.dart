import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  void goToHome() => setSelectedIndex(0);
  void goToFavorites() => setSelectedIndex(1);
  void goToCart() => setSelectedIndex(2);
  void goToProfile() => setSelectedIndex(3);
}
