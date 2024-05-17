import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:uuid/uuid.dart';

import '../../../Core/Storage_Service/firebase_storage.dart';

class PostService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postData(String description, File file, List likes) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('Users').doc(_auth.currentUser!.uid).get();

    String username = snapshot.get('username');

    DocumentSnapshot profileSnap = await _firestore
        .collection('Profile Picture')
        .doc(_auth.currentUser!.uid)
        .get();

    String profileURL = profileSnap.get('photoURL');

    final postPhotoURL =
        await Storage().imageStorage('Post Pictures Collection', file, true);

    final postId = const Uuid().v1();

    if (username.isNotEmpty || profileURL.isNotEmpty) {
      await _firestore
          .collection('Post Collections')
          .doc(_auth.currentUser!.uid)
          .set({
        'username': username,
        'profileURL': profileURL,
        'description': description,
        'likes': likes,
        'uid': _auth.currentUser!.uid,
        'postId': postId,
        'postPhotoURL': postPhotoURL,
      });
    }
  }
}
