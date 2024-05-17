import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Core/Storage_Service/firebase_storage.dart';

class ProfileService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> storeProfile(File file) async {
    if (_firebaseAuth.currentUser != null) {
      final photoURL = await Storage()
          .imageStorage('Profile Picture Collection', file, false);

      await _firebaseFirestore
          .collection('Profile Picture')
          .doc(_firebaseAuth.currentUser!.uid)
          .set({
        'photoURL': photoURL,
      });
    }
  }
}
