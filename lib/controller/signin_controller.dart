import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackit/view/bottombar.dart';

class SignInController with ChangeNotifier {
  var emailController = TextEditingController(); // Use for email
  var signInPasswordController = TextEditingController(); // Use for password
  var userSignInKey = GlobalKey<FormState>();
  bool showUserPass = true;
  String apptext = "";

  // Toggle password visibility
  void togglePasswordVisibility() {
    showUserPass = !showUserPass;
    notifyListeners();
  }

  // Validate the form
  bool validateForm() {
    return userSignInKey.currentState?.validate() ?? false;
  }


// Sign-in method using FirebaseAuth
Future<void> signIn(BuildContext context) async {
  if (validateForm()) {
    try {
      // ignore: unused_local_variable
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: signInPasswordController.text,
      );

      // Navigate to Bottombar after successful login
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const Bottombar()),
      );
    } catch (e) {
      // ignore: avoid_print
      print(e); // Log the error for debugging
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in: ${e.toString()}')));
    }
  }
}


  // Clean up controllers
  void disposeControllers() {
    emailController.dispose();
    signInPasswordController.dispose();
  }
}


