import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../helper/helper_method.dart';
import 'comment_button.dart';
import 'comment.dart';
import 'like_button.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postId;
  final List<String> likes;
  final String? imageUrl;

  const WallPost({
    Key? key,
    required this.user,
    required this.time,
    required this.message,
    required this.postId,
    required this.likes,
    this.imageUrl,
  }) : super(key: key);

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final _commentTextController = TextEditingController();
  File? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
    _imageUrl = widget.imageUrl;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
    FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now(),
    });
  }

  void _deleteComment(String commentId) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .doc(commentId)
        .delete()
        .then((_) {
      setState(() {});
    }).catchError((error) {
      print("Failed to delete comment: $error");
    });
  }

  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Comment"),
        content: TextField(
          controller: _commentTextController,
          decoration: InputDecoration(hintText: "Write a comment..."),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              addComment(_commentTextController.text);
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: Text("Post"),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null) {
        setState(() {
          _imageFile = File.fromRawPath(Uint8List.fromList(result.files.single.bytes!));
        });
        _uploadImageToFirebaseStorage();
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _uploadImageToFirebaseStorage() async {
    if (_imageFile != null) {
      try {
        Reference ref = FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');
        UploadTask uploadTask = ref.putFile(_imageFile!);

        await uploadTask.whenComplete(() async {
          String imageUrl = await ref.getDownloadURL();
          setState(() {
            _imageUrl = imageUrl; // Update the image URL after uploading
          });
          _addPostToFirestore(imageUrl);
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    } else {
      print('No image to upload.');
    }
  }

  void _addPostToFirestore(String imageUrl) {
    FirebaseFirestore.instance.collection("User Posts").add({
      "User": currentUser.email,
      "Time": Timestamp.now(),
      "Message": widget.message,
      "Likes": [],
      "ImageUrl": imageUrl,
    }).then((value) {
      setState(() {
        _imageUrl = imageUrl;
      });
    }).catchError((error) {
      print("Failed to add post: $error");
    });
  }

  void _deletePost() {
    // Verificar si el usuario actual coincide con el usuario que creó el post
    if (currentUser.email == widget.user) {
      FirebaseFirestore.instance.collection("User Posts").doc(widget.postId).delete().then((value) {
        Navigator.pop(context); // Cerrar la página actual después de eliminar el post
      }).catchError((error) {
        print("Failed to delete post: $error");
      });
    } else {
      // Si el usuario actual no coincide con el usuario que creó el post, mostrar un mensaje de error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("You can only delete posts that you have uploaded."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el diálogo
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 181, 2),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.message,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(widget.user, style: TextStyle(color: Colors.grey)),
                  Text(" . ", style: TextStyle(color: Colors.grey)),
                  Text(widget.time, style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 20),
              if (_imageUrl != null || _imageFile != null)
                _imageUrl != null
                    ? Image.network(_imageUrl!, width: 200, height: 200)
                    : Container(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      LikeButton(isLiked: isLiked, onTap: toggleLike),
                      const SizedBox(width: 5),
                      Text(widget.likes.length.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      CommentButton(onTap: showCommentDialog),
                      const SizedBox(width: 5),
                      Text(
                        '0',
                        style: TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: _deletePost,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Pick Image'),
                  ),
                  const SizedBox(width: 10),
                  Visibility(
                    visible: _imageFile != null,
                    child: ElevatedButton(
                      onPressed: _imageFile != null ? () => _uploadImageToFirebaseStorage() : null,
                      child: Text('Upload Image'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("User Posts")
                    .doc(widget.postId)
                    .collection("Comments")
                    .orderBy("CommentTime", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map((doc) {
                      final commentData = doc.data() as Map<String, dynamic>;
                      final commentId = doc.id;
                      return Comment(
                        text: commentData["CommentText"],
                        user: commentData["CommentedBy"],
                        time: formatDate(commentData["CommentTime"]),
                        onDelete: () => _deleteComment(commentId),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Wall Posts'),
      ),
      body: WallPost(
        user: 'User Name',
        time: '2024-05-14 12:00',
        message: 'This is a sample message.',
        postId: 'postId',
        likes: [],
        imageUrl: null,
      ),
    ),
  ));
}
