import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_model.dart';
import '../model/product_model.dart';

class CartProvider with ChangeNotifier {
  Cart _cart = Cart();
  static const String _cartKey = 'shopping_cart';

  Cart get cart => _cart;

  int get itemCount => _cart.itemCount;

  double get subtotal => _cart.subtotal;

  double get tax => _cart.tax;

  double get shipping => _cart.shipping;

  double get total => _cart.total;

  bool get isEmpty => _cart.isEmpty;

  bool get isNotEmpty => _cart.isNotEmpty;

  List<CartItem> get items => _cart.items;

  // Initialize cart from storage
  Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(_cartKey);
      if (cartJson != null) {
        final Map<String, dynamic> decoded = json.decode(cartJson);
        _cart = Cart.fromJson(decoded);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading cart: $e');
    }
  }

  // Save cart to storage
  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = json.encode(_cart.toJson());
      await prefs.setString(_cartKey, cartJson);
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  // Add product to cart
  Future<void> addToCart(ProductModel product, {int quantity = 1}) async {
    if (!product.isAvailable) {
      throw Exception('Product is not available');
    }

    final existingItem = _cart.findItem(product.id);

    if (existingItem != null) {
      // Update quantity if item already exists
      final newQuantity = existingItem.quantity + quantity;
      if (newQuantity > product.stock) {
        throw Exception('Not enough stock available');
      }
      await updateQuantity(product.id, newQuantity);
    } else {
      // Add new item
      if (quantity > product.stock) {
        throw Exception('Not enough stock available');
      }
      final newItems = List<CartItem>.from(_cart.items)
        ..add(CartItem(product: product, quantity: quantity));
      _cart = Cart(items: newItems);
      notifyListeners();
      await _saveCart();
    }
  }

  // Remove product from cart
  Future<void> removeFromCart(String productId) async {
    final newItems = _cart.items
        .where((item) => item.product.id != productId)
        .toList();
    _cart = Cart(items: newItems);
    notifyListeners();
    await _saveCart();
  }

  // Update quantity of a cart item
  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeFromCart(productId);
      return;
    }

    final item = _cart.findItem(productId);
    if (item != null) {
      if (newQuantity > item.product.stock) {
        throw Exception('Not enough stock available');
      }

      final newItems = _cart.items.map((cartItem) {
        if (cartItem.product.id == productId) {
          return cartItem.copyWith(quantity: newQuantity);
        }
        return cartItem;
      }).toList();

      _cart = Cart(items: newItems);
      notifyListeners();
      await _saveCart();
    }
  }

  // Increment quantity
  Future<void> incrementQuantity(String productId) async {
    final item = _cart.findItem(productId);
    if (item != null) {
      await updateQuantity(productId, item.quantity + 1);
    }
  }

  // Decrement quantity
  Future<void> decrementQuantity(String productId) async {
    final item = _cart.findItem(productId);
    if (item != null) {
      await updateQuantity(productId, item.quantity - 1);
    }
  }

  // Clear entire cart
  Future<void> clearCart() async {
    _cart = Cart();
    notifyListeners();
    await _saveCart();
  }

  // Check if product is in cart
  bool hasProduct(String productId) {
    return _cart.hasProduct(productId);
  }

  // Get quantity of specific product
  int getProductQuantity(String productId) {
    return _cart.getProductQuantity(productId);
  }
}
