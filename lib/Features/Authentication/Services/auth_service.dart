import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUpWithEmailPassword(
      String email, String password, String userName) async {
    UserCredential credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firebaseFirestore.collection('Users').doc(credential.user!.uid).set({
      'username': userName,
      'uid': credential.user!.uid,
      'email': email,
      'following': [],
      'followers': [],
    });
  }

  Future<void> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);

    final currentUser = _firebaseAuth.currentUser!;

    await _firebaseFirestore.collection('Users').doc(currentUser.uid).set({
      'username': currentUser.displayName,
      'uid': currentUser.uid,
      'email': currentUser.email,
    });
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
