import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/model/review_model.dart';
import 'package:uuid/uuid.dart';

class ReviewsProvider with ChangeNotifier {
  final List<ReviewModel> _reviews = [
    ReviewModel(
      id: '1',
      productId:
          '1', // Assuming ID 1 exists or matches some product logic. For now, we will associate manually.
      // Ideally, we match IDs. But since Product IDs are generated dynamically often, we might need to handle that.
      // For this demo, let's just populate some generic reviews that we show for ANY product or specific ones if we know IDs.
      // We'll filter by product ID in the getter.
      userName: 'John Doe',
      rating: 4.5,
      comment: 'Great car! highly recommended.',
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    ReviewModel(
      id: '2',
      productId: '1',
      userName: 'Alice Smith',
      rating: 5.0,
      comment: 'Amazing experience, smooth drive.',
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
  ];

  List<ReviewModel> getReviewsForProduct(String productId) {
    // For demo purposes, if the list is empty for a specific ID, return the mock ones so every car has reviews
    // In a real app, this would return matches only.
    final matches = _reviews.where((r) => r.productId == productId).toList();
    if (matches.isEmpty) {
      // Return mock reviews with customized ID to pretend they are for this product
      return _reviews
          .map(
            (r) => ReviewModel(
              id: Uuid().v4(),
              productId: productId,
              userName: r.userName,
              userImage: r.userImage,
              rating: r.rating,
              comment: r.comment,
              date: r.date,
            ),
          )
          .toList();
    }
    return matches;
  }

  void addReview(ReviewModel review) {
    _reviews.add(review);
    notifyListeners();
  }

  double getAverageRating(String productId) {
    final reviews = getReviewsForProduct(productId);
    if (reviews.isEmpty) return 0.0;
    final total = reviews.fold(0.0, (sum, item) => sum + item.rating);
    return total / reviews.length;
  }
}
