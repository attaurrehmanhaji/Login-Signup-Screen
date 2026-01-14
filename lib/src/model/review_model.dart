class ReviewModel {
  final String id;
  final String productId;
  final String userName;
  final String? userImage;
  final double rating;
  final String comment;
  final DateTime date;

  ReviewModel({
    required this.id,
    required this.productId,
    required this.userName,
    this.userImage,
    required this.rating,
    required this.comment,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'userName': userName,
      'userImage': userImage,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      userName: json['userName'] as String,
      userImage: json['userImage'] as String?,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }
}
