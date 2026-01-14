import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import '../model/order_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  static const String _userKey = 'user_data';

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  String get userName => _user?.name ?? 'Guest';

  String get userEmail => _user?.email ?? '';

  List<Address> get addresses => _user?.addresses ?? [];

  Address? get defaultAddress => _user?.defaultAddress;

  // Initialize user from storage
  Future<void> loadUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson != null) {
        final Map<String, dynamic> decoded = json.decode(userJson);
        _user = User.fromJson(decoded);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
    }
  }

  // Save user to storage
  Future<void> _saveUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_user != null) {
        final userJson = json.encode(_user!.toJson());
        await prefs.setString(_userKey, userJson);
      }
    } catch (e) {
      debugPrint('Error saving user: $e');
    }
  }

  // Login user
  Future<void> login(User user) async {
    _user = user;
    notifyListeners();
    await _saveUser();
  }

  // Logout user
  Future<void> logout() async {
    _user = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Update user profile
  Future<void> updateProfile({
    String? name,
    String? phoneNumber,
    String? profileImageUrl,
  }) async {
    if (_user != null) {
      _user = _user!.copyWith(
        name: name,
        phoneNumber: phoneNumber,
        profileImageUrl: profileImageUrl,
      );
      notifyListeners();
      await _saveUser();
    }
  }

  // Add address
  Future<void> addAddress(Address address) async {
    if (_user != null) {
      final newAddresses = List<Address>.from(_user!.addresses)..add(address);
      _user = _user!.copyWith(addresses: newAddresses);
      notifyListeners();
      await _saveUser();
    }
  }

  // Update address
  Future<void> updateAddress(String addressId, Address updatedAddress) async {
    if (_user != null) {
      final newAddresses = _user!.addresses.map((addr) {
        return addr.id == addressId ? updatedAddress : addr;
      }).toList();
      _user = _user!.copyWith(addresses: newAddresses);
      notifyListeners();
      await _saveUser();
    }
  }

  // Delete address
  Future<void> deleteAddress(String addressId) async {
    if (_user != null) {
      final newAddresses = _user!.addresses
          .where((addr) => addr.id != addressId)
          .toList();
      _user = _user!.copyWith(addresses: newAddresses);
      notifyListeners();
      await _saveUser();
    }
  }

  // Set default address
  Future<void> setDefaultAddress(String addressId) async {
    if (_user != null) {
      final newAddresses = _user!.addresses.map((addr) {
        return addr.copyWith(isDefault: addr.id == addressId);
      }).toList();
      _user = _user!.copyWith(addresses: newAddresses);
      notifyListeners();
      await _saveUser();
    }
  }
}
