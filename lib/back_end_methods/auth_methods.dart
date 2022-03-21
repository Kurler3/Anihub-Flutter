import 'dart:typed_data';

import 'package:anihub_flutter/back_end_methods/database_methods.dart';
import 'package:anihub_flutter/back_end_methods/storage_methods.dart';
import 'package:anihub_flutter/models/user.dart' as modal;
import 'package:anihub_flutter/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // STREAM LISTENING TO USER CHANGES
  Stream<User?> get userChanges => _firebaseAuth.authStateChanges();

  Future<String> signInWithGoogle() async {
    String result = FAIL_VALUE;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Log in firebase
      await FirebaseAuth.instance.signInWithCredential(credential);

      result = SUCCESS_VALUE;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      result = e.toString();
    } catch (e) {
      debugPrint(e.toString());
      result = e.toString();
    }

    return result;
  }

  // LOGIN
  Future<String> signIn(
      {required String email, required String password}) async {
    String result = FAIL_VALUE;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      result = SUCCESS_VALUE;
    } catch (e) {
      debugPrint(e.toString());
      result = e.toString();
    }

    return result;
  }

  // REGISTER
  Future<String> signUp({
    required String username,
    required String email,
    required String password,
    String? premadeBackgroundPic,
    String? premadeProfilePic,
    Uint8List? backgroundPic,
    Uint8List? profilePic,
  }) async {
    String result = FAIL_VALUE;

    try {
      // SIGN UP
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // STORE PROFILE AND BACKGROUND IN STORAGE AND GET DOWNLOAD URL IF NOT
      // USING PREMADE

      String? background = premadeBackgroundPic;
      String? profile = premadeProfilePic;

      if (premadeBackgroundPic == null) {
        // Store backgroundPic in storage.
        background = await StorageMethods().uploadProfileBackgroundPic(
            userId: userCredential.user!.uid,
            isProfilePic: false,
            picData: backgroundPic!);
      }

      if (premadeProfilePic == null) {
        // Store profile pic in storage.
        profile = await StorageMethods().uploadProfileBackgroundPic(
            userId: userCredential.user!.uid,
            isProfilePic: true,
            picData: profilePic!);
      }

      // CREATE USER INSTANCE
      modal.UserModel user = modal.UserModel(
        uid: userCredential.user!.uid,
        username: username,
        displayUsername: username,
        email: email,
        profilePicUrl: profile!,
        backgroundPicUrl: background!,
        followers: [],
        following: [],
        favoriteAnimes: [],
        watchList: [],
        currentlyWatching: [],
        finishedWatching: [],
      );

      // REGISTER IN FIRESTORE.
      await DatabaseMethods().uploadUser(userData: user);

      // RESULT = SUCCESS AND RETURN.
      result = SUCCESS_VALUE;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());

      result = e.toString();
    } catch (e) {
      debugPrint(e.toString());
      result = e.toString();
    }

    return result;
  }

  // LOG OFF
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
