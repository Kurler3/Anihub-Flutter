import 'dart:ffi';

import 'package:anihub_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // CREATE USER
  Future<void> uploadUser({required UserModal userData}) async {
    // NO NEED FOR TRY CATCH BECAUSE THIS FUNCTION IS CALLED INSIDE A TRY AND CATCH BLOCK.

    await _firebaseFirestore.collection('users').doc(userData.uid).set(
          UserModal.toMap(userData: userData),
        );
  }

  // GET USER DETAILS
  Future<UserModal?> getUserDetails() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        return null;
      }

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firebaseFirestore.collection('users').doc(user.uid).get();

      return UserModal.fromMap(map: documentSnapshot.data()!);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
