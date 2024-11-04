import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ScreenImagePicker extends StatefulWidget {
  const ScreenImagePicker({super.key});

  @override
  State<ScreenImagePicker> createState() => _ScreenImagePickerState();
}

class _ScreenImagePickerState extends State<ScreenImagePicker> {
  Uint8List? image;

  imagePick(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    return ("No image Selected");
  }

  void selectimage() async {
    Uint8List img = await imagePick(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            image != null
                ? Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: MemoryImage(image!))
                  ),
                  )
                : const CircleAvatar(),
            ElevatedButton(
                onPressed: () {
                  selectimage();
                },
                child: const Text("Select Image")),
          ],
        ),
      ),
    );
  }
}
