// ignore_for_file: file_names

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _googleUser;
  User? _firebaseUser;
  String? _uid;
  bool _isLoading = false; // Loading state
  String? _errorMessage; // Error message in case of failure

  GoogleSignInAccount? get googleUser => _googleUser;
  User? get firebaseUser => _firebaseUser;
  String? get uid => _uid;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> googleLogin() async {
    _isLoading = true; // Start loading
    _errorMessage = null; // Reset error message
    notifyListeners();

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User aborted login
        _isLoading = false;
        notifyListeners();
        return false;
      }
      _googleUser = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _firebaseUser = userCredential.user;
      _uid = _firebaseUser?.uid; // Extract uid from Firebase user

      _isLoading = false; // Stop loading
      notifyListeners();
      return true; // Successful login
    } catch (e) {
      // Handle login error
      log(e.toString());
      _isLoading = false;
      _errorMessage = _getErrorMessage(e); // Get user-friendly error message
      notifyListeners();
      return false; // Login failed
    }
  }

  String _getErrorMessage(Object error) {
    // Convert error to a user-friendly message
    // Customize this function as needed
    return error.toString();
  }

  Future<void> logout() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut(); // Ensure sign out is complete
    _googleUser = null;
    _firebaseUser = null;
    _uid = null;
    notifyListeners();
  }
}
