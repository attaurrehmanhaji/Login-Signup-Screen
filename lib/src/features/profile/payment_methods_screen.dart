import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  // Mock data for payment methods
  final List<Map<String, dynamic>> _savedCards = [
    {
      'cardNumber': '**** **** **** 4242',
      'cardHolder': 'John Doe',
      'expiryDate': '12/26',
      'cardType': 'Visa',
      'color': [Color(0xFF1A1F71), Color(0xFF0037B6)], // Visa Colors
    },
    {
      'cardNumber': '**** **** **** 5555',
      'cardHolder': 'John Doe',
      'expiryDate': '09/25',
      'cardType': 'Mastercard',
      'color': [Color(0xFFEB001B), Color(0xFFF79E1B)], // Mastercard Colors
    },
  ];

  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  void _showAddCardSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add New Card',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildTextField(
                      'Card Number',
                      _cardNumberController,
                      keyboardType: TextInputType.number,
                      hint: '0000 0000 0000 0000',
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      'Card Holder Name',
                      _cardHolderController,
                      hint: 'John Doe',
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            'Expiry Date',
                            _expiryController,
                            keyboardType: TextInputType.datetime,
                            hint: 'MM/YY',
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: _buildTextField(
                            'CVV',
                            _cvvController,
                            keyboardType: TextInputType.number,
                            hint: '123',
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // In a real app, validate and tokenise with Stripe/Payment Provider
                            // Here we just mock adding it to the list
                            setState(() {
                              _savedCards.add({
                                'cardNumber':
                                    '**** **** **** ${_cardNumberController.text.substring(_cardNumberController.text.length - 4)}',
                                'cardHolder': _cardHolderController.text,
                                'expiryDate': _expiryController.text,
                                'cardType': 'Visa', // Mock
                                'color': [Colors.grey[800]!, Colors.black],
                              });
                            });

                            _cardNumberController.clear();
                            _cardHolderController.clear();
                            _expiryController.clear();
                            _cvvController.clear();

                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Card added successfully!'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Save Card',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    String? hint,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.grayColor.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.grayColor.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.orangeColor),
        ),
        filled: true,
        fillColor: AppColors.grayColor.withOpacity(0.05),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: AppBar(
        title: Text(
          'Payment Methods',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _savedCards.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.credit_card_off_outlined,
                    size: 80,
                    color: AppColors.grayColor,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No cards saved yet',
                    style: TextStyle(fontSize: 18, color: AppColors.grayColor),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: _savedCards.length,
              itemBuilder: (context, index) {
                final card = _savedCards[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      _savedCards.removeAt(index);
                    });
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Card removed')));
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: AppColors.errorRed,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                  child: Container(
                    height: 200,
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: card['color'],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: card['color'][0].withOpacity(0.4),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.contactless,
                              color: Colors.white.withOpacity(0.8),
                              size: 30,
                            ),
                            Text(
                              card['cardType'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          card['cardNumber'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontFamily: 'Courier', // Monospace for card number
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CARD HOLDER',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 10,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  card['cardHolder'].toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'EXPIRES',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 10,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  card['expiryDate'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCardSheet(context),
        backgroundColor: AppColors.orangeColor,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add New Card',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
