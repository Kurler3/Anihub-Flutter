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
      DocumentSnapshot<Map<String, dynamic>> animeSnapshot =
          await _firebaseFirestore
              .collection('animes')
              .doc(animeData.id.toString())
              .get();

      Map<String, dynamic> setData;

      if (animeSnapshot.exists) {
        setData = {
          "favoritedBy": isAdd
              ? [...animeSnapshot.data()!['favoritedBy'], user.uid]
              : animeSnapshot
                  .data()!['favoritedBy']
                  .where((userId) => userId != user.uid)
                  .toList(),
        };
      } else {
        setData = AnimeBackend.toMap(
          animeBackend: AnimeBackend(
            uid: animeData.id.toString(),
            favoritedBy: [user.uid],
            nativeTitle: animeData.nativeTitle!,
            status: animeData.status,
            englishTitle: animeData.englishTitle,
            romajiTitle: animeData.romajiTitle,
          ),
        );
      }

      // NEED TO ADD/REMOVE FROM ANIME BACK-END IN FIREBASE
      await _firebaseFirestore
          .collection('animes')
          .doc(animeData.id.toString())
          .set(setData, SetOptions(merge: true));

      // RETURN NEW USER MODEL
      userModel.favoriteAnimes = newFavoritedList;

      return userModel;
    } catch (e) {
      debugPrint("Error adding/removing favorite anime" + e.toString());
      return null;
    }
  }

  // ANIME METHODS

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAnimeBackendDetails(
          int id) =>
      _firebaseFirestore.collection("animes").doc(id.toString()).snapshots();

  Future<bool> checkIfDocExists(String collectionName, String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = _firebaseFirestore.collection(collectionName);

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      debugPrint("Error checking if doc exists: " + e.toString());
      return false;
    }
  }
}
