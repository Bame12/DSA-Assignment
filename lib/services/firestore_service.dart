import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_finder/models/doctor_model.dart';
import 'package:doctor_finder/models/appointment_model.dart';
import 'package:doctor_finder/models/review_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // DOCTORS
  
  // Get all doctors
  Future<List<Doctor>> getDoctors() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('doctors').get();
      return snapshot.docs.map((doc) {
        return Doctor.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error getting doctors: $e');
      return [];
    }
  }
  
  // Get doctors by specialty
  Future<List<Doctor>> getDoctorsBySpecialty(String specialty) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('doctors')
          .where('specialty', isEqualTo: specialty)
          .get();
      return snapshot.docs.map((doc) {
        return Doctor.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error getting doctors by specialty: $e');
      return [];
    }
  }
  
  // Get doctor by ID
  Future<Doctor?> getDoctorById(String id) async {
    try {
      final DocumentSnapshot doc = await _firestore.collection('doctors').doc(id).get();
      if (doc.exists) {
        return Doctor.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      print('Error getting doctor by ID: $e');
      return null;
    }
  }
  
  // APPOINTMENTS
  
  // Create appointment
  Future<String> createAppointment(Appointment appointment) async {
    try {
      final DocumentReference docRef = await _firestore.collection('appointments').add(
        appointment.toMap(),
      );
      return docRef.id;
    } catch (e) {
      print('Error creating appointment: $e');
      throw Exception('Failed to create appointment');
    }
  }
  
  // Get user appointments
  Future<List<Appointment>> getUserAppointments(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('appointments')
          .where('patientId', isEqualTo: userId)
          .get();
      return snapshot.docs.map((doc) {
        return Appointment.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error getting user appointments: $e');
      return [];
    }
  }
  
  // REVIEWS
  
  // Add review
  Future<String> addReview(Review review) async {
    try {
      // Add review
      final DocumentReference docRef = await _firestore.collection('reviews').add(
        review.toMap(),
      );
      
      // Update doctor's rating
      await updateDoctorRating(review.doctorId);
      
      return docRef.id;
    } catch (e) {
      print('Error adding review: $e');
      throw Exception('Failed to add review');
    }
  }
  
  // Get doctor reviews
  Future<List<Review>> getDoctorReviews(String doctorId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('reviews')
          .where('doctorId', isEqualTo: doctorId)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((doc) {
        return Review.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error getting doctor reviews: $e');
      return [];
    }
  }
  
  // Update doctor rating
  Future<void> updateDoctorRating(String doctorId) async {
    try {
      // Get all reviews for the doctor
      final QuerySnapshot snapshot = await _firestore
          .collection('reviews')
          .where('doctorId', isEqualTo: doctorId)
          .get();
      
      final List<Review> reviews = snapshot.docs.map((doc) {
        return Review.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      
      // Calculate new rating
      if (reviews.isNotEmpty) {
        double totalRating = 0;
        for (var review in reviews) {
          totalRating += review.rating;
        }
        double averageRating = totalRating / reviews.length;
        
        // Update doctor document
        await _firestore.collection('doctors').doc(doctorId).update({
          'rating': averageRating,
          'reviewCount': reviews.length,
        });
      }
    } catch (e) {
      print('Error updating doctor rating: $e');
    }
  }
}
