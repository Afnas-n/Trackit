import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackit/Model/user_model.dart';
import 'package:trackit/controller/database_services.dart';

class SignUpController with ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool showPassword = true;
  bool confirmPasswordVisible = true;

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible = !confirmPasswordVisible;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPassController.text.isNotEmpty) {
      
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        
        String id = credential.user!.uid;
        UserModel userInfo = UserModel(
          username: nameController.text,
          email: emailController.text.trim(),
          password: passwordController.text,
          id: id,
        );

        await DatabaseService().addUserDetails(userInfo, id);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/signin');
      } catch (e) {
        // ignore: avoid_print
        print(e); // Handle the error appropriately
      }
    }
  }

  void disposeController() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    
  }
}
