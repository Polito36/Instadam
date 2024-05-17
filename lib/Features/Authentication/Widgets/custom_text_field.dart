import 'package:flutter/material.dart';
import '../../../Core/Constants/pallete.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool obscureText;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.text,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      cursorColor: Colors.black,
      controller: controller,
      style: const TextStyle(
        color: Pallete.primaryTextColor,
        fontFamily: 'Sofia Pro',
        fontWeight: FontWeight.w400,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(
          color: Pallete.primaryTextColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
