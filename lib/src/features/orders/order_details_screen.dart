import 'package:flutter/material.dart';
import '../../core/constants/appColors.dart';
import '../../model/order_model.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('MMM dd, yyyy - hh:mm a');

    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.grayColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order Details',
          style: TextStyle(
            color: AppColors.grayColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID Card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryGradientStart,
                    AppColors.primaryGradientEnd,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '#${order.orderId}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    dateFormat.format(order.orderDate),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            // Order Status
            _buildSectionTitle('Order Status'),
            SizedBox(height: 15),
            _buildOrderTimeline(),
            SizedBox(height: 25),
            // Items
            _buildSectionTitle('Items'),
            SizedBox(height: 15),
            ...order.items
                .map((item) => _buildOrderItem(item, currencyFormat))
                .toList(),
            SizedBox(height: 25),
            // Shipping Address
            _buildSectionTitle('Shipping Address'),
            SizedBox(height: 15),
            _buildInfoCard(
              icon: Icons.location_on,
              title: order.shippingAddress.fullName,
              subtitle: order.shippingAddress.fullAddress,
            ),
            SizedBox(height: 25),
            // Payment Method
            _buildSectionTitle('Payment Method'),
            SizedBox(height: 15),
            _buildInfoCard(
              icon: Icons.payment,
              title: order.paymentMethod,
              subtitle: 'Payment successful',
            ),
            SizedBox(height: 25),
            // Order Summary
            _buildSectionTitle('Order Summary'),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'Subtotal',
                    currencyFormat.format(order.subtotal),
                  ),
                  SizedBox(height: 10),
                  _buildSummaryRow('Tax', currencyFormat.format(order.tax)),
                  SizedBox(height: 10),
                  _buildSummaryRow(
                    'Shipping',
                    currencyFormat.format(order.shipping),
                  ),
                  Divider(height: 30),
                  _buildSummaryRow(
                    'Total',
                    currencyFormat.format(order.totalAmount),
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.grayColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildOrderTimeline() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildTimelineStep(
            'Confirmed',
            order.status.index >= OrderStatus.confirmed.index,
            isFirst: true,
          ),
          _buildTimelineLine(
            order.status.index >= OrderStatus.processing.index,
          ),
          _buildTimelineStep(
            'Processing',
            order.status.index >= OrderStatus.processing.index,
          ),
          _buildTimelineLine(order.status.index >= OrderStatus.shipped.index),
          _buildTimelineStep(
            'Shipped',
            order.status.index >= OrderStatus.shipped.index,
          ),
          _buildTimelineLine(order.status.index >= OrderStatus.delivered.index),
          _buildTimelineStep(
            'Delivered',
            order.status.index >= OrderStatus.delivered.index,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    String label,
    bool isActive, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.successGreen
                : AppColors.grayColor.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: isActive
              ? Icon(Icons.check, color: Colors.white, size: 16)
              : null,
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive
                ? AppColors.grayColor
                : AppColors.grayColor.withOpacity(0.5),
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTimelineLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: EdgeInsets.only(bottom: 20),
        color: isActive
            ? AppColors.successGreen
            : AppColors.grayColor.withOpacity(0.3),
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item, NumberFormat currencyFormat) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  AppColors.secondaryGradientStart.withOpacity(0.3),
                  AppColors.secondaryGradientEnd.withOpacity(0.3),
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(item.product.photo, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: TextStyle(
                    color: AppColors.grayColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Qty: ${item.quantity}',
                  style: TextStyle(
                    color: AppColors.grayColor.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            currencyFormat.format(item.totalPrice),
            style: TextStyle(
              color: AppColors.orangeColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightOrangeColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.orangeColor),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.grayColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.grayColor.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.grayColor.withOpacity(isTotal ? 1.0 : 0.6),
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? AppColors.orangeColor : AppColors.grayColor,
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
