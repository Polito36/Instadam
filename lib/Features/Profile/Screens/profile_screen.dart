import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../Core/Constants/pallete.dart';
import '../../Authentication/Services/auth_service.dart';
import '../Services/profile_storage_service.dart';
import '../Utils/photo_picker.dart';
import '../Widgets/custom_button.dart';

class ProfileScreen extends StatefulHookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String username = '';
  File? _selectedImage;

  @override
  void initState() {
    getUserName();

    super.initState();
  }

  void getUserName() async {
    final name = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = name['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Pallete.primaryTextColor,
            fontFamily: 'Sofia Pro',
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _selectedImage != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: FileImage(_selectedImage!),
                      )
                    : Stack(
                        children: [
                          const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                              'https://media.istockphoto.com/id/476085198/photo/businessman-silhouette-as-avatar-or-default-profile-picture.jpg?s=612x612&w=0&k=20&c=GVYAgYvyLb082gop8rg0XC_wNsu0qupfSLtO7q9wu38=',
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () async {
                                final image = await PhotoPicker().pickPhoto();
                                if (image != null) {
                                  setState(() {
                                    _selectedImage = File(image.path);
                                  });
                                  ProfileService()
                                      .storeProfile(_selectedImage!);
                                }
                              },
                              icon: const Icon(
                                Icons.add_photo_alternate,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              username,
              style: const TextStyle(
                color: Pallete.primaryTextColor,
                fontFamily: 'Sofia Pro',
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CustomElevatedButton(
                  text: 'Edit Profile',
                ),
                CustomElevatedButton(
                  onTap: () {
                    AuthService().logout();
                  },
                  text: 'logout',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
