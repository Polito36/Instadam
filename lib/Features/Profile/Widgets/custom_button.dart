import 'package:flutter/material.dart';
import '../../../Core/Constants/pallete.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const CustomElevatedButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Pallete.secondaryTextColor,
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Pallete.primaryTextColor,
            fontFamily: 'Sofia Pro',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
