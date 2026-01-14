import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/order_model.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];
  static const String _ordersKey = 'orders';

  List<Order> get orders => _orders;

  int get count => _orders.length;

  bool get isEmpty => _orders.isEmpty;

  bool get isNotEmpty => _orders.isNotEmpty;

  // Get orders by status
  List<Order> getOrdersByStatus(OrderStatus status) {
    return _orders.where((order) => order.status == status).toList();
  }

  // Get pending orders
  List<Order> get pendingOrders => getOrdersByStatus(OrderStatus.pending);

  // Get confirmed orders
  List<Order> get confirmedOrders => getOrdersByStatus(OrderStatus.confirmed);

  // Get delivered orders
  List<Order> get deliveredOrders => getOrdersByStatus(OrderStatus.delivered);

  // Initialize orders from storage
  Future<void> loadOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = prefs.getString(_ordersKey);
      if (ordersJson != null) {
        final List<dynamic> decoded = json.decode(ordersJson);
        _orders = decoded
            .map(
              (orderJson) => Order.fromJson(orderJson as Map<String, dynamic>),
            )
            .toList();
        // Sort by date (newest first)
        _orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading orders: $e');
    }
  }

  // Save orders to storage
  Future<void> _saveOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = json.encode(
        _orders.map((order) => order.toJson()).toList(),
      );
      await prefs.setString(_ordersKey, ordersJson);
    } catch (e) {
      debugPrint('Error saving orders: $e');
    }
  }

  // Add new order
  Future<void> addOrder(Order order) async {
    _orders.insert(0, order); // Add to beginning (newest first)
    notifyListeners();
    await _saveOrders();
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    final orderIndex = _orders.indexWhere((order) => order.orderId == orderId);
    if (orderIndex != -1) {
      _orders[orderIndex] = _orders[orderIndex].copyWith(status: newStatus);
      notifyListeners();
      await _saveOrders();
    }
  }

  // Get order by ID
  Order? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.orderId == orderId);
    } catch (e) {
      return null;
    }
  }

  // Cancel order
  Future<void> cancelOrder(String orderId) async {
    await updateOrderStatus(orderId, OrderStatus.cancelled);
  }

  // Clear all orders (for testing/logout)
  Future<void> clearOrders() async {
    _orders.clear();
    notifyListeners();
    await _saveOrders();
  }
}
