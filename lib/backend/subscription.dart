import 'package:cloud_firestore/cloud_firestore.dart';

class Subscription {
  String? id; // ID of the subscription
  String? type; // Type of the subscription (e.g., Basic, Premium, Pro)
  DateTime? startDate; // Date when the subscription was activated
  DateTime? endDate; // Date when the subscription will expire

  Subscription({this.id, this.type, this.startDate, this.endDate});

  // Convert Subscription to Map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "type": type,
      "startDate": startDate,
      "endDate": endDate,
    };
  }

  // Create Subscription from Map
  static Subscription fromMap(Map<String, dynamic>? map) {
    return Subscription(
      id: map?['id'],
      type: map?['type'],
      startDate: map?['startDate'] != null ? map!['startDate'].toDate() : null,
      endDate: map?['endDate'] != null ? map!['endDate'].toDate() : null,
    );
  }
}

class LexitSubscription {
  Future<List<Subscription>> getUserSubscriptions(String userId) async {
    try {
      QuerySnapshot subscriptionsSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("subscriptions")
          .get();

      List<Subscription> subscriptions = subscriptionsSnapshot.docs
          .map(
              (doc) => Subscription.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return subscriptions;
    } catch (error) {
      rethrow;
    }
  }
}
