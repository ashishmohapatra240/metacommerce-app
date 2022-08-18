import 'dart:convert';

class Rating {
  final String id;
  final String userId;
  final double rating;
  Rating({
    required this.id,
    required this.userId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userId': userId,
      'rating': rating,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}