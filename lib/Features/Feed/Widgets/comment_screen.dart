import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../Core/Constants/pallete.dart';
import '../Service/comment_service.dart';
import 'like_animation.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  void comment() async {
    await CommentService().storeComment(_commentController.text, widget.postId);
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      appBar: AppBar(
        backgroundColor: Pallete.bgColor,
        title: const Text(
          'Comments',
          style: TextStyle(
            color: Pallete.primaryTextColor,
            fontFamily: 'Sofia Pro',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Comment')
            .doc(widget.postId)
            .collection('comments')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data!.docs[index]['profileURL']),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.docs[index]['username'],
                                style: TextStyle(
                                  color: Pallete.primaryTextColor,
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                snapshot.data!.docs[index]['comment'],
                                style: TextStyle(
                                  color: Pallete.primaryTextColor,
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        CustomLikeButton(onTap: () {})
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          controller: _commentController,
          obscureText: false,
          autocorrect: false,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: 'comment.....',
            suffixIcon: IconButton(
              onPressed: () {
                comment();
              },
              icon: const Icon(
                Icons.send,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
