import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';
import 'package:login_signin_screens/src/model/order_model.dart';
import 'package:login_signin_screens/src/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _showAddAddressSheet(BuildContext context) {
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
                  'Add New Address',
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
                    _buildTextField('Full Name', _nameController),
                    SizedBox(height: 15),
                    _buildTextField(
                      'Phone Number',
                      _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 15),
                    _buildTextField('Street Address', _streetController),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField('City', _cityController),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: _buildTextField('State', _stateController),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      'Zip Code',
                      _zipController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final newAddress = Address(
                              id: Uuid().v4(),
                              fullName: _nameController.text,
                              phoneNumber: _phoneController.text,
                              addressLine1: _streetController.text,
                              city: _cityController.text,
                              state: _stateController.text,
                              postalCode: _zipController.text,
                              country: 'USA', // Default
                            );

                            Provider.of<UserProvider>(
                              context,
                              listen: false,
                            ).addAddress(newAddress);

                            _nameController.clear();
                            _phoneController.clear();
                            _streetController.clear();
                            _cityController.clear();
                            _stateController.clear();
                            _zipController.clear();

                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Address added successfully!'),
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
                          'Save Address',
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
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
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
    final userProvider = Provider.of<UserProvider>(context);
    final addresses = userProvider.user?.addresses ?? [];

    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: AppBar(
        title: Text(
          'My Addresses',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: addresses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_off_outlined,
                    size: 80,
                    color: AppColors.grayColor,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No addresses saved yet',
                    style: TextStyle(fontSize: 18, color: AppColors.grayColor),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(20),
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.orangeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: AppColors.orangeColor,
                      ),
                    ),
                    title: Text(
                      address.fullName, // Now using fullName
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          address.phoneNumber,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.grayColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${address.addressLine1}, ${address.city}, ${address.state} ${address.postalCode}',
                          style: TextStyle(color: AppColors.grayColor),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: AppColors.errorRed,
                      ),
                      onPressed: () {
                        userProvider.deleteAddress(address.id);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddAddressSheet(context),
        backgroundColor: AppColors.orangeColor,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add New Address',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
