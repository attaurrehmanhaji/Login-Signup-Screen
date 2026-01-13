import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';
import 'package:login_signin_screens/src/model/cars_model.dart';
import 'dart:ui';

class CarDetails extends StatefulWidget {
  final CarsModel car;
  const CarDetails({super.key, required this.car});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Added to favorites' : 'Removed from favorites',
        ),
        duration: Duration(seconds: 1),
        backgroundColor: AppColors.grayColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleBooking() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.successGreen,
                  size: 50,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Booking Successful!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grayColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your request for the ${widget.car.brand} ${widget.car.name} has been sent to the dealer. They will contact you shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.grayColor.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Go back to home
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orangeColor,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Back to Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          // Hero Image Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.car.photo),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                        Colors.black.withOpacity(0.1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Custom App Bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircularButton(
                  context,
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Navigator.pop(context),
                ),
                _buildCircularButton(
                  context,
                  icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                  iconColor: isFavorite
                      ? AppColors.errorRed
                      : AppColors.grayColor,
                  onTap: _toggleFavorite,
                ),
              ],
            ),
          ),

          // Scrollable Content
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.4 - 30,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  25,
                  30,
                  25,
                  120,
                ), // Added bottom padding to avoid fab overlap
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle Bar
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.grayColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),

                    // Header Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.car.brand.toUpperCase(),
                              style: TextStyle(
                                color: AppColors.orangeColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.car.name,
                              style: TextStyle(
                                color: AppColors.grayColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                SizedBox(width: 4),
                                Text(
                                  '4.8',
                                  style: TextStyle(
                                    color: AppColors.grayColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '(120 reviews)',
                              style: TextStyle(
                                color: AppColors.grayColor.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    // Specifications Grid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSpecCard(
                          icon: Icons.calendar_today,
                          label: 'Year',
                          value: widget.car.model.toString(),
                        ),
                        _buildSpecCard(
                          icon: Icons.speed,
                          label: 'Mileage',
                          value: '15k km',
                        ),
                        _buildSpecCard(
                          icon: Icons.palette_outlined,
                          label: 'Color',
                          value: widget.car.color,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    // Description
                    Text(
                      'Description',
                      style: TextStyle(
                        color: AppColors.grayColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Experience the ultimate driving pleasure with the ${widget.car.brand} ${widget.car.name}. Featuring a premium interior, advanced safety systems, and a powerful engine that delivers exceptional performance on every journey.',
                      style: TextStyle(
                        color: AppColors.grayColor.withOpacity(0.7),
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Features List
                    Text(
                      'Key Features',
                      style: TextStyle(
                        color: AppColors.grayColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildFeatureChip('Autopilot'),
                        _buildFeatureChip('360° Camera'),
                        _buildFeatureChip('Heated Seats'),
                        _buildFeatureChip('Bluetooth'),
                        _buildFeatureChip('GPS Navigation'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                            color: AppColors.grayColor.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '\$45,000',
                          style: TextStyle(
                            color: AppColors.grayColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _handleBooking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orangeColor,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        shadowColor: AppColors.orangeColor.withOpacity(0.5),
                      ),
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildCircularButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor ?? AppColors.grayColor, size: 20),
      ),
    );
  }

  Widget _buildSpecCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grayColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lightOrangeColor.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.orangeColor, size: 20),
          ),
          SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              color: AppColors.grayColor.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: AppColors.grayColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.grayColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grayColor.withOpacity(0.1)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.grayColor.withOpacity(0.8),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
