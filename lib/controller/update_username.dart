import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUsernameService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<void> updateUsername(String userId, String newUsername) async {
    try {
      // Update the username field in Firestore
      await usersCollection.doc(userId).update({'username': newUsername});
    } catch (e) {
      // Handle errors
      // ignore: avoid_print
      print('Error updating username: $e');
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }
}
