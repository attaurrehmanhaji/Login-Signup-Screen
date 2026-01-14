import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/product_model.dart';

class FavoritesProvider with ChangeNotifier {
  Set<String> _favoriteIds = {};
  static const String _favoritesKey = 'favorites';

  Set<String> get favoriteIds => _favoriteIds;

  int get count => _favoriteIds.length;

  bool get isEmpty => _favoriteIds.isEmpty;

  bool get isNotEmpty => _favoriteIds.isNotEmpty;

  // Initialize favorites from storage
  Future<void> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString(_favoritesKey);
      if (favoritesJson != null) {
        final List<dynamic> decoded = json.decode(favoritesJson);
        _favoriteIds = decoded.cast<String>().toSet();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  // Save favorites to storage
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = json.encode(_favoriteIds.toList());
      await prefs.setString(_favoritesKey, favoritesJson);
    } catch (e) {
      debugPrint('Error saving favorites: $e');
    }
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String productId) async {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifyListeners();
    await _saveFavorites();
  }

  // Add to favorites
  Future<void> addFavorite(String productId) async {
    if (!_favoriteIds.contains(productId)) {
      _favoriteIds.add(productId);
      notifyListeners();
      await _saveFavorites();
    }
  }

  // Remove from favorites
  Future<void> removeFavorite(String productId) async {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      notifyListeners();
      await _saveFavorites();
    }
  }

  // Check if product is favorite
  bool isFavorite(String productId) {
    return _favoriteIds.contains(productId);
  }

  // Clear all favorites
  Future<void> clearFavorites() async {
    _favoriteIds.clear();
    notifyListeners();
    await _saveFavorites();
  }

  // Get favorite products from a list
  List<ProductModel> getFavoriteProducts(List<ProductModel> allProducts) {
    return allProducts
        .where((product) => _favoriteIds.contains(product.id))
        .toList();
  }
}
