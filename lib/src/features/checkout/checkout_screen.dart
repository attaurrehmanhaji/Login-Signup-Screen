import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/appColors.dart';
import '../../providers/cart_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/orders_provider.dart';
import '../../model/order_model.dart';
import '../orders/order_confirmation_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  Address? _selectedAddress;
  String _selectedPaymentMethod = 'Credit Card';
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final currencyFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
    );

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
          'Checkout',
          style: TextStyle(
            color: AppColors.grayColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () async {
          if (_currentStep < 2) {
            setState(() => _currentStep++);
          } else {
            await _processOrder(context, cartProvider, userProvider);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isProcessing ? null : details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangeColor,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: _isProcessing
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            _currentStep == 2 ? 'Place Order' : 'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                if (_currentStep > 0) ...[
                  SizedBox(width: 12),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: Text(
                      'Back',
                      style: TextStyle(color: AppColors.grayColor),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        steps: [
          Step(
            title: Text('Shipping Address'),
            content: _buildAddressStep(userProvider),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: Text('Payment Method'),
            content: _buildPaymentStep(),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: Text('Review Order'),
            content: _buildReviewStep(cartProvider, currencyFormat),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildAddressStep(UserProvider userProvider) {
    if (userProvider.addresses.isEmpty) {
      return _buildDemoAddress();
    }

    _selectedAddress ??= userProvider.defaultAddress;

    return Column(
      children: userProvider.addresses.map((address) {
        return RadioListTile<Address>(
          value: address,
          groupValue: _selectedAddress,
          onChanged: (value) {
            setState(() => _selectedAddress = value);
          },
          title: Text(address.fullName),
          subtitle: Text(address.fullAddress),
          activeColor: AppColors.orangeColor,
        );
      }).toList(),
    );
  }

  Widget _buildDemoAddress() {
    // Create a demo address for testing
    final demoAddress = Address(
      id: '1',
      fullName: 'John Doe',
      phoneNumber: '+1 234 567 8900',
      addressLine1: '123 Main Street',
      addressLine2: 'Apt 4B',
      city: 'New York',
      state: 'NY',
      postalCode: '10001',
      country: 'USA',
      isDefault: true,
    );

    _selectedAddress = demoAddress;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.orangeColor.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.orangeColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lightOrangeColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.location_on, color: AppColors.orangeColor),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      demoAddress.fullName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.orangeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Default',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.orangeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  demoAddress.fullAddress,
                  style: TextStyle(color: AppColors.grayColor.withOpacity(0.8)),
                ),
                SizedBox(height: 4),
                Text(
                  demoAddress.phoneNumber,
                  style: TextStyle(
                    color: AppColors.grayColor.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    final paymentMethods = ['Credit Card', 'PayPal', 'Cash on Delivery'];

    return Column(
      children: paymentMethods.map((method) {
        return RadioListTile<String>(
          value: method,
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() => _selectedPaymentMethod = value!);
          },
          title: Text(method),
          secondary: Icon(
            _getPaymentIcon(method),
            color: AppColors.orangeColor,
          ),
          activeColor: AppColors.orangeColor,
        );
      }).toList(),
    );
  }

  IconData _getPaymentIcon(String method) {
    switch (method) {
      case 'Credit Card':
        return Icons.credit_card;
      case 'PayPal':
        return Icons.account_balance_wallet;
      case 'Cash on Delivery':
        return Icons.money;
      default:
        return Icons.payment;
    }
  }

  Widget _buildReviewStep(
    CartProvider cartProvider,
    NumberFormat currencyFormat,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.grayColor,
          ),
        ),
        SizedBox(height: 15),
        ...cartProvider.items.map((item) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${item.product.name} x${item.quantity}',
                    style: TextStyle(color: AppColors.grayColor),
                  ),
                ),
                Text(
                  currencyFormat.format(item.totalPrice),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.grayColor,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        Divider(height: 30),
        _buildSummaryRow(
          'Subtotal',
          currencyFormat.format(cartProvider.subtotal),
        ),
        _buildSummaryRow('Tax', currencyFormat.format(cartProvider.tax)),
        _buildSummaryRow(
          'Shipping',
          currencyFormat.format(cartProvider.shipping),
        ),
        Divider(height: 30),
        _buildSummaryRow(
          'Total',
          currencyFormat.format(cartProvider.total),
          isTotal: true,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
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
      ),
    );
  }

  Future<void> _processOrder(
    BuildContext context,
    CartProvider cartProvider,
    UserProvider userProvider,
  ) async {
    if (_selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a shipping address'),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }

    setState(() => _isProcessing = true);

    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));

    // Create order
    final orderId = Uuid().v4().substring(0, 8).toUpperCase();
    final order = Order(
      orderId: orderId,
      items: cartProvider.items
          .map(
            (item) => OrderItem(
              product: item.product,
              quantity: item.quantity,
              priceAtPurchase: item.product.price,
            ),
          )
          .toList(),
      subtotal: cartProvider.subtotal,
      tax: cartProvider.tax,
      shipping: cartProvider.shipping,
      totalAmount: cartProvider.total,
      status: OrderStatus.confirmed,
      orderDate: DateTime.now(),
      estimatedDelivery: DateTime.now().add(Duration(days: 7)),
      shippingAddress: _selectedAddress!,
      paymentMethod: _selectedPaymentMethod,
    );

    // Save order
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    await ordersProvider.addOrder(order);

    // Clear cart
    await cartProvider.clearCart();

    setState(() => _isProcessing = false);

    // Navigate to confirmation
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => OrderConfirmationScreen(order: order),
      ),
      (route) => route.isFirst,
    );
  }
}
