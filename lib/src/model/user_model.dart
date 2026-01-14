import 'order_model.dart';

class User {
  final String userId;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profileImageUrl;
  final List<Address> addresses;
  final DateTime createdAt;

  User({
    required this.userId,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profileImageUrl,
    this.addresses = const [],
    required this.createdAt,
  });

  Address? get defaultAddress {
    try {
      return addresses.firstWhere((addr) => addr.isDefault);
    } catch (e) {
      return addresses.isNotEmpty ? addresses.first : null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'addresses': addresses.map((addr) => addr.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      addresses:
          (json['addresses'] as List<dynamic>?)
              ?.map((addr) => Address.fromJson(addr as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  User copyWith({
    String? userId,
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    List<Address>? addresses,
    DateTime? createdAt,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      addresses: addresses ?? this.addresses,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
