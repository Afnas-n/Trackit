import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.textHint,
    required this.iconSi,
    required this.textController,
    required this.textValidator,
    required this.obesCuretext,
    this.suffixIcon,
  });

  final String textHint;
  final Widget iconSi;
  final TextEditingController textController;
  final FormFieldValidator textValidator;
  final bool obesCuretext;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obesCuretext,
      controller: textController,
      validator: textValidator,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 216, 245, 236),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
            borderSide: BorderSide.none),
        hintText: textHint,
        prefixIcon: iconSi,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
