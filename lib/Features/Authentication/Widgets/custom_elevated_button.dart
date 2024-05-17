import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.buttonColor,
    required this.text,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 330,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            buttonColor,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
