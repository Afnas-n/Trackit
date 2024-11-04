import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/controller/custom_validator.dart';
import 'package:trackit/controller/signin_controller.dart';
import 'package:trackit/view/custom_texfield.dart';
import 'package:trackit/view/signup_page.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signInController = Provider.of<SignInController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          signInController.apptext,
          style: const TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: signInController.userSignInKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                  ),
                  const Text(
                    "Enter Your Credential to login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 85),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomTextfield(
                      textHint: 'Email',
                      iconSi: const Icon(Icons.person),
                      textController: signInController.emailController,
                      textValidator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Can\'t be empty';
                        }
                        return null;
                      },
                      obesCuretext: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomTextfield(
                      textHint: 'Password',
                      iconSi: const Icon(Icons.password),
                      textController: signInController.signInPasswordController,
                      textValidator: (value) =>
                          Validation().passwordValidator(value),
                      obesCuretext: signInController.showUserPass,
                      suffixIcon: IconButton(
                        onPressed: () =>
                            signInController.togglePasswordVisibility(),
                        icon: signInController.showUserPass
                            ? const Icon(Icons.visibility_rounded)
                            : const Icon(Icons.visibility_off_rounded),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 33, 206, 153),
                      fixedSize: const Size.fromWidth(310),
                    ),
                    onPressed: () {
                      // Call the signIn method from the controller
                      signInController.signIn(context);
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 100),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style:
                          TextStyle(color: Color.fromARGB(255, 33, 206, 153)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign up',
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
  }
}
