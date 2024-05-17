import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../Core/Constants/pallete.dart';
import '../../Profile/Utils/photo_picker.dart';
import '../Services/post_services.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;
  String photoURL = '';

  @override
  void initState() {
    getProfileUrl();
    super.initState();
  }

  void getProfileUrl() async {
    final photo = await FirebaseFirestore.instance
        .collection('Profile Picture')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      photoURL = photo['photoURL'];
    });
  }

  void postData() async {
    await PostService().postData(
      _descriptionController.text,
      _imageFile!,
      [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Pallete.bgColor,
          centerTitle: false,
          title: const Text(
            'Create a new post',
            style: TextStyle(
              color: Pallete.primaryTextColor,
              fontFamily: 'Sofia Pro',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.blue[100],
                  ),
                ),
                onPressed: postData,
                child: const Text(
                  'Post',
                  style: TextStyle(
                    color: Pallete.primaryTextColor,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Post Collections')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            photoURL,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _descriptionController,
                            autocorrect: false,
                            cursorColor: Colors.black,
                            maxLines: 2,
                            decoration: const InputDecoration(
                              hintMaxLines: 6,
                              hintText:
                                  'Let your voice be heard and connect with others through your words. Inspire, or simply express yourself. What is on your mind ?',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _imageFile != null
                        ? Expanded(
                            child: Image.file(
                              fit: BoxFit.cover,
                              _imageFile!,
                            ),
                          )
                        : SizedBox(
                            height: 50,
                            width: 250,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.blue[100])),
                              onPressed: () async {
                                final pickedImage =
                                    await PhotoPicker().pickPhoto();
                                if (pickedImage != null) {
                                  setState(() {
                                    _imageFile = File(pickedImage.path);
                                  });
                                }
                              },
                              child: const Text(
                                'Choose an Image',
                                style:
                                    TextStyle(color: Pallete.primaryTextColor),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
