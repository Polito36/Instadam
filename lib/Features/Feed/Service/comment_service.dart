import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeComment(String comment, String postId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('Users').doc(_auth.currentUser!.uid).get();

    String username = snapshot.get('username');

    DocumentSnapshot profileURL = await _firestore
        .collection('Profile Picture')
        .doc(_auth.currentUser!.uid)
        .get();

    String profileURl = profileURL.get('photoURL');

    await _firestore
        .collection('Comment')
        .doc(postId)
        .collection('comments')
        .add({
      'comment': comment,
      'profileURL': profileURl,
      'username': username,
    });
  }
}
