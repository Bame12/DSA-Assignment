class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String about;
  final String email;
  final String phone;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final String photoUrl;
  final bool isAvailable;
  final bool acceptsInsurance;
  final double rating;
  final int reviewCount;
  final int experience;
  final String education;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.about,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.photoUrl,
    required this.isAvailable,
    required this.acceptsInsurance,
    required this.rating,
    required this.reviewCount,
    required this.experience,
    required this.education,
  });

  factory Doctor.fromMap(Map<String, dynamic> map, String id) {
    return Doctor(
      id: id,
      name: map['name'] ?? '',
      specialty: map['specialty'] ?? '',
      about: map['about'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? 'Gaborone',
      latitude: (map['latitude'] ?? 0).toDouble(),
      longitude: (map['longitude'] ?? 0).toDouble(),
      photoUrl: map['photoUrl'] ?? '',
      isAvailable: map['isAvailable'] ?? true,
      acceptsInsurance: map['acceptsInsurance'] ?? false,
      rating: (map['rating'] ?? 0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      experience: map['experience'] ?? 0,
      education: map['education'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'specialty': specialty,
      'about': about,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'photoUrl': photoUrl,
      'isAvailable': isAvailable,
      'acceptsInsurance': acceptsInsurance,
      'rating': rating,
      'reviewCount': reviewCount,
      'experience': experience,
      'education': education,
    };
  }
}
