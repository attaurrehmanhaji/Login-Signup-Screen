import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';
import 'package:login_signin_screens/src/providers/notifications_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationsProvider = Provider.of<NotificationsProvider>(context);
    final notifications = notificationsProvider.notifications;

    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.done_all, color: AppColors.orangeColor),
            onPressed: () {
              notificationsProvider.markAllAsRead();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('All notifications marked as read')),
              );
            },
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 80,
                    color: AppColors.grayColor,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No notifications yet',
                    style: TextStyle(fontSize: 18, color: AppColors.grayColor),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            notificationsProvider.deleteNotification(
                              notification.id,
                            );
                          },
                          backgroundColor: AppColors.errorRed,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: notification.isRead
                            ? Colors.white
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowLight,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                        border: notification.isRead
                            ? null
                            : Border.all(
                                color: AppColors.orangeColor.withOpacity(0.3),
                                width: 1,
                              ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(20),
                        leading: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _getIconColor(
                              notification.type,
                            ).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getIcon(notification.type),
                            color: _getIconColor(notification.type),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                            if (!notification.isRead)
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppColors.orangeColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              notification.body,
                              style: TextStyle(
                                color: AppColors.grayColor.withOpacity(0.8),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              DateFormat.jm().add_yMMMd().format(
                                notification.date,
                              ),
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.grayColor.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          notificationsProvider.markAsRead(notification.id);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'order':
        return Icons.shopping_bag;
      case 'promo':
        return Icons.local_offer;
      case 'system':
        return Icons.info;
      default:
        return Icons.notifications;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'order':
        return AppColors.successGreen;
      case 'promo':
        return AppColors.orangeColor;
      case 'system':
        return AppColors.accentBlue;
      default:
        return AppColors.grayColor;
    }
  }
}
