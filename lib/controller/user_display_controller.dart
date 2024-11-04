import 'package:flutter/material.dart';
import 'package:trackit/Model/user_model.dart';
import 'package:trackit/controller/database_services.dart';
import 'package:trackit/controller/update_username.dart';


class UserProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final UpdateUsernameService _updateUsernameService = UpdateUsernameService();

  Stream<List<UserModel>>? _userStream;

  Stream<List<UserModel>> get userStream {
    _userStream ??= _databaseService.getUserDetails();
    return _userStream!;
  }

  // Updated function to call the UpdateUsernameService
  Future<void> updateUsername(String id, String updatedUsername) async {
    try {
      // Call the UpdateUsernameService to update in Firestore
      await _updateUsernameService.updateUsername(id, updatedUsername);
      notifyListeners(); // Notify listeners to rebuild the UI
    } catch (e) {
      // ignore: avoid_print
      print('Error updating username: $e');
    }
  }
}
