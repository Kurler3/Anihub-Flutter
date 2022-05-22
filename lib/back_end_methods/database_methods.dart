import 'package:anihub_flutter/classes/anime/anime.dart';
import 'package:anihub_flutter/models/anime_backend.dart';
import 'package:anihub_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // CREATE USER
  Future<void> uploadUser({required UserModel userData}) async {
    // NO NEED FOR TRY CATCH BECAUSE THIS FUNCTION IS CALLED INSIDE A TRY AND CATCH BLOCK.

    await _firebaseFirestore.collection('users').doc(userData.uid).set(
          UserModel.toMap(userData: userData),
        );
  }

  // GET USER DETAILS
  Future<UserModel?> getUserDetails() async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user == null) {
        return null;
      }

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firebaseFirestore.collection('users').doc(user.uid).get();

      return UserModel.fromMap(map: documentSnapshot.data()!);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  // ADD/REMOVE FROM FAVORITE ANIMES LIST
  Future<UserModel?> addRemoveFavoriteAnime(bool isAdd, Anime animeData) async {
    try {
      User? user = _firebaseAuth.currentUser;

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firebaseFirestore.collection('users').doc(user!.uid).get();

      UserModel userModel = UserModel.fromMap(map: documentSnapshot.data()!);

      List<String> newFavoritedList = isAdd
          ? [...userModel.favoriteAnimes, animeData.id.toString()]
          : userModel.favoriteAnimes
              .where((animeId) => animeId != animeData.id.toString())
              .toList();

      // NEED TO ADD/REMOVE FROM USER MODEL IN FIREBASE
      await _firebaseFirestore.collection('users').doc(userModel.uid).set({
        "favoriteAnimes": newFavoritedList,
      }, SetOptions(merge: true));

      // GET ANIME DATA BACK-END

      // IF DOESN'T EXIST, THEN CREATE.
      // OTHERWISE MERGE THE favoritedBy WITH EXISTING ONE.

      // NEED TO ADD/REMOVE FROM ANIME BACK-END IN FIREBASE
      await _firebaseFirestore
          .collection('animes')
          .doc(animeData.id.toString())
          .set(
              AnimeBackend.toMap(
                  animeBackend: AnimeBackend(
                      uid: animeData.id.toString(),
                      favoritedBy: favoritedBy,
                      nativeTitle: nativeTitle,
                      status: status)),
              SetOptions(merge: true));

      // RETURN NEW USER MODEL
      userModel.favoriteAnimes = newFavoritedList;

      return userModel;
    } catch (e) {
      debugPrint("Error adding/removing favorite anime" + e.toString());
    }
  }

  // ANIME METHODS

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAnimeBackendDetails(
          int id) =>
      _firebaseFirestore.collection("animes").doc(id.toString()).snapshots();
}
