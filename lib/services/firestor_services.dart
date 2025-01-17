import 'package:cloud_firestore/cloud_firestore.dart';

import '../modal/modal.dart';

class FirestoreServices {
  FirestoreServices._();

  static FirestoreServices firestoreServices = FirestoreServices._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserToFirestore(UserModal user) async {
    await _firestore.collection("users").add(toMap(user));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserFromFirestore() {
    return _firestore.collection("users").snapshots();
  }
}