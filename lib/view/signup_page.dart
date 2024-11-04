import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/controller/custom_validator.dart';
import 'package:trackit/controller/google_signin_controller.dart';
import 'package:trackit/controller/signup_controller.dart';
import 'package:trackit/view/custom_texfield.dart';
import 'package:trackit/view/home_page.dart';
import 'package:trackit/view/signin_page.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => GoogleSignInController()),
      ],
      child: Consumer<SignUpController>(
        builder: (context, controller, _) {
          // ignore: no_leading_underscores_for_local_identifiers
          final _formKey = GlobalKey<FormState>();

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey, // Use GlobalKey for form
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                          ],
                        ),
                        const Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text('Create Your account'),
                        const SizedBox(height: 10),
                        CustomTextfield(
                          textController: controller.nameController,
                          textValidator: (value) {
                            if (value!.isEmpty) {
                              return 'Username can\'t be empty';
                            }
                            return null;
                          },
                          textHint: 'Username',
                          iconSi: const Icon(Icons.person),
                          obesCuretext: false,
                        ),
                        const SizedBox(height: 20),
                        CustomTextfield(
                          textHint: 'Email',
                          iconSi: const Icon(Icons.email),
                          textController: controller.emailController,
                          textValidator: (value) =>
                              Validation().emailValidator(value),
                          obesCuretext: false,
                        ),
                        const SizedBox(height: 20),
                        CustomTextfield(
                          textHint: "Password",
                          iconSi: const Icon(Icons.password),
                          textController: controller.passwordController,
                          textValidator: (value) =>
                              Validation().passwordValidator(value),
                          obesCuretext: controller.showPassword,
                          suffixIcon: IconButton(
                            onPressed: controller.togglePasswordVisibility,
                            icon: controller.showPassword
                                ? const Icon(Icons.visibility_rounded)
                                : const Icon(Icons.visibility_off_rounded),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextfield(
                          textHint: 'Confirm Password',
                          iconSi: const Icon(Icons.password),
                          textController: controller.confirmPassController,
                          textValidator: (value) {
                            if (value!.isEmpty) {
                              return 'Empty';
                            }
                            if (value != controller.passwordController.text) {
                              return 'Password not match';
                            }
                            return null;
                          },
                          obesCuretext: controller.confirmPasswordVisible,
                          suffixIcon: IconButton(
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                            icon: controller.confirmPasswordVisible
                                ? const Icon(Icons.visibility_rounded)
                                : const Icon(Icons.visibility_off_rounded),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 33, 206, 153),
                            fixedSize: const Size.fromWidth(300),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.signUp(context);
                            }
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text('Or'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            final googleController =
                                Provider.of<GoogleSignInController>(context,
                                    listen: false);

                            final success =
                                await googleController.googleLogin();

                            if (success) {
                              // Navigate to HomePage after successful sign-in
                              Navigator.pushReplacement(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            } else {
                              // Show error message or handle failure
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(googleController.errorMessage ??
                                      'Google sign-in failed'),
                                ),
                              );
                            }
                          },
                          child:
                              context.watch<GoogleSignInController>().isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Sign in with Google'),
                        ),
                        TextButton(
                            onPressed: () async {
                              final googleController = GoogleSignInController();
                              await googleController.logout();
                            },
                            child: const Text('Logout')),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account? '),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SigninPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 33, 206, 153)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
