import 'package:flutter/material.dart';
import 'package:trackit/view/bottombar.dart';
import 'package:trackit/view/image_picker.dart';
import 'package:trackit/view/signin_page.dart';
import 'package:trackit/view/user_display.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SigninPage(),
                ),
              );
            },
            child: const Text('Go to Sign In'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserDisplay(),
                ),
              );
            },
            child: const Text('User Details'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Bottombar(),
                ),
              );
            },
            child: const Text('Bottom bar'), // Correct child here
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenImagePicker(),
                ),
              );
            },
            child: const Text('Image Picker'), // Correct child here
          ),
        ],
      ),
    );
  }
}
