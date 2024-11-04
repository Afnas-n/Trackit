import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackit/Model/user_model.dart';

class DatabaseService {
  final storeUser = FirebaseFirestore.instance.collection('Users');

  Future addUserDetails(UserModel userInfoMap, String id) async {
    return await storeUser.doc(id).set(userInfoMap.toJson());
  }

  Stream<List<UserModel>> getUserDetails() {
    return storeUser.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => UserModel.fromJson(doc.data()))
              .toList(),
        );
  }

//   Stream<List<UserModel>> getUserDetails() {
//   return storeUser.snapshots().map((snapshot) {
//     return snapshot.docs.map((doc) {
//       return UserModel.fromJson(doc.data());
//     }).toList();
//   });
// }

}
