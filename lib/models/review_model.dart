class Review {
  final String id;
  final String doctorId;
  final String userId;
  final String userName;
  final int rating;
  final String text;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.text,
    required this.createdAt,
  });

  factory Review.fromMap(Map<String, dynamic> map, String id) {
    return Review(
      id: id,
      doctorId: map['doctorId'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      rating: map['rating'] ?? 0,
      text: map['text'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'text': text,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}
