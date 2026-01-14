import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/model/notification_model.dart';

class NotificationsProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'Order Placed Successfully',
      body: 'Your order #12345 has been placed successfully.',
      date: DateTime.now().subtract(Duration(hours: 2)),
      type: 'order',
      isRead: false,
    ),
    NotificationModel(
      id: '2',
      title: 'Big Sale - 20% Off!',
      body: 'Get 20% off on all sports cars this weekend only.',
      date: DateTime.now().subtract(Duration(days: 1)),
      type: 'promo',
      isRead: true,
    ),
    NotificationModel(
      id: '3',
      title: 'Welcome to CarStore',
      body: 'Thanks for joining us! Start exploring our premium collection.',
      date: DateTime.now().subtract(Duration(days: 5)),
      type: 'system',
      isRead: true,
    ),
  ];

  List<NotificationModel> get notifications =>
      List.unmodifiable(_notifications);

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllAsRead() {
    _notifications = _notifications
        .map((n) => n.copyWith(isRead: true))
        .toList();
    notifyListeners();
  }

  void deleteNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }
}
