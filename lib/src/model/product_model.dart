class ProductModel {
  final String id;
  final String name;
  final String brand;
  final String category;
  final int year;
  final String color;
  final String photo;
  final List<String> images;
  final double price;
  final String description;
  final List<String> features;
  final double rating;
  final int reviewCount;
  final int stock;
  final bool sold;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.year,
    required this.color,
    required this.photo,
    this.images = const [],
    required this.price,
    this.description = '',
    this.features = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.stock = 0,
    this.sold = false,
    this.isFavorite = false,
  });

  // Create from old CarsModel format for backward compatibility
  factory ProductModel.fromCarsModel({
    required String name,
    required String brand,
    required String color,
    required int model,
    required String photo,
    required bool sold,
    String? id,
    double? price,
  }) {
    return ProductModel(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      brand: brand,
      category: brand,
      year: model,
      color: color,
      photo: photo,
      images: [photo],
      price: price ?? 45000.0,
      description:
          'Experience the ultimate driving pleasure with the $brand $name. '
          'Featuring a premium interior, advanced safety systems, and a powerful engine '
          'that delivers exceptional performance on every journey.',
      features: [
        'Autopilot',
        '360° Camera',
        'Heated Seats',
        'Bluetooth',
        'GPS Navigation',
      ],
      rating: 4.8,
      reviewCount: 120,
      stock: sold ? 0 : 5,
      sold: sold,
      isFavorite: false,
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'year': year,
      'color': color,
      'photo': photo,
      'images': images,
      'price': price,
      'description': description,
      'features': features,
      'rating': rating,
      'reviewCount': reviewCount,
      'stock': stock,
      'sold': sold,
      'isFavorite': isFavorite,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      category: json['category'] as String,
      year: json['year'] as int,
      color: json['color'] as String,
      photo: json['photo'] as String,
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String? ?? '',
      features: (json['features'] as List<dynamic>?)?.cast<String>() ?? [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      stock: json['stock'] as int? ?? 0,
      sold: json['sold'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  // Copy with method for immutability
  ProductModel copyWith({
    String? id,
    String? name,
    String? brand,
    String? category,
    int? year,
    String? color,
    String? photo,
    List<String>? images,
    double? price,
    String? description,
    List<String>? features,
    double? rating,
    int? reviewCount,
    int? stock,
    bool? sold,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      year: year ?? this.year,
      color: color ?? this.color,
      photo: photo ?? this.photo,
      images: images ?? this.images,
      price: price ?? this.price,
      description: description ?? this.description,
      features: features ?? this.features,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      stock: stock ?? this.stock,
      sold: sold ?? this.sold,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  bool get isAvailable => stock > 0 && !sold;
}
