import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../Core/Constants/pallete.dart';
import 'comment_screen.dart';
import 'like_animation.dart';

class FeedCard extends StatelessWidget {
  final String description;
  final String image;
  final String username;
  final String postImage;
  final String postId;
  const FeedCard(
      {super.key,
      required this.description,
      required this.image,
      required this.username,
      required this.postImage,
      required this.postId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Pallete.bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  image,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 120.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        color: Pallete.primaryTextColor,
                        fontFamily: 'Sofia Pro',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      '30 sec ago',
                      style: TextStyle(
                        color: Pallete.secondaryTextColor,
                        fontFamily: 'Sofia Pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Pallete.secondaryTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Image.network(
            fit: BoxFit.cover,
            postImage,
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            children: [
              CustomLikeButton(
                onTap: () {},
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentScreen(
                        postId: postId,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.comment,
                  color: Pallete.secondaryTextColor,
                  size: 25,
                ),
              ),
            ],
          ),
          Text(
            description,
            style: const TextStyle(
              color: Pallete.primaryTextColor,
              fontFamily: 'Sofia Pro',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
