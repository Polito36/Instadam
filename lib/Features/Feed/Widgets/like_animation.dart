import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CustomLikeButton extends StatelessWidget {
  final VoidCallback onTap;
  const CustomLikeButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LikeButton(
        animationDuration: Duration(milliseconds: 1000),
        likeCount: 0,
      ),
    );
  }
}
