import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? googleUser;
  User? firebaseUser;

  Future<void> googleSignIn() async {
    googleUser = _googleSignIn.currentUser;
    firebaseUser = _auth.currentUser;

    try {
      googleUser ??= await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      if (firebaseUser == null) {
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        firebaseUser = (await _auth.signInWithCredential(credential)).user;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    firebaseUser = null;
    debugPrint('Deslogado!');
  }
}
