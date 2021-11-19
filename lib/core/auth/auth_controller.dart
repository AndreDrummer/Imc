import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  AuthController._();
  static final AuthController authController = AuthController._();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? googleUser;
  User? firebaseUser;

  Future<void> checkSignedIn() async {
    googleUser = _googleSignIn.currentUser;
    googleUser ??= await _googleSignIn.signInSilently();
    firebaseUser = _auth.currentUser;
  }

  Future<void> googleSignIn() async {
    await checkSignedIn();

    if (firebaseUser == null) {
      try {
        googleUser ??= await _googleSignIn.signIn();
        GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        firebaseUser = (await _auth.signInWithCredential(credential)).user;
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  }

  void signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    firebaseUser = null;
    debugPrint('Deslogado!');
  }
}
