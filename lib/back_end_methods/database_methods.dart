import 'package:anihub_flutter/classes/anime/anime.dart';
import 'package:anihub_flutter/models/anime_backend.dart';
import 'package:anihub_flutter/models/anime_comment.dart';
import 'package:anihub_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //----------------------- USERS ------------------------------
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

  // ADD/REMOVE FROM USERS WATCHLIST
  Future<UserModel?> addRemoveFromWatchlist(bool isAdd, Anime animeData) async {
    try {
      User? user = _firebaseAuth.currentUser;

      DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot =
          await _firebaseFirestore.collection('users').doc(user!.uid).get();

      UserModel userModel =
          UserModel.fromMap(map: userDocumentSnapshot.data()!);

      List<String> newWatchlist = isAdd
          ? [...userModel.watchList, animeData.id.toString()]
          : userModel.watchList
              .where((id) => id != animeData.id.toString())
              .toList();

      _firebaseFirestore.collection('users').doc(userModel.uid).set({
        "watchList": newWatchlist,
      }, SetOptions(merge: true));

      userModel.watchList = newWatchlist;

      return userModel;
    } catch (e) {
      debugPrint("Error when adding/removing from watchlist" + e.toString());
      return null;
    }
  }

  //------------------------------------------------------------//

  //----------------- ANIME METHODS ---------------------------//

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAnimeBackendDetails(
          int id) =>
      _firebaseFirestore.collection("animes").doc(id.toString()).snapshots();

  // GET NUM OF LIKES GIVEN AN ANIME ID.
  Future<int> getAnimeFavCount(
    Anime animeData,
  ) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> animeSnapshot =
          await _firebaseFirestore
              .collection("animes")
              .doc(animeData.id.toString())
              .get();

      return animeSnapshot.exists
          ? AnimeBackend.fromMap(animeSnapshot.data()!).favoritedBy.length
          : 0;
    } catch (e) {
      debugPrint("Error fetching anime fav count: " + e.toString());
      return 0;
    }
  }

  //------------------------------------------------------------//

  // --------------------------COMMENTS-------------------------//

  // GET COMMENTS GIVEN LEVEL FROM ANIME BACK-END
  Query<Map<String, dynamic>> getAnimeComments(
      String animeUid, int level, String? parentCommentUid) {
    Query<Map<String, dynamic>> documentList = _firebaseFirestore
        .collection('animes')
        .doc(animeUid)
        .collection('comments')
        .where(
          'level',
          isEqualTo: level,
        )
        .where(
          "parentCommentUid",
          isEqualTo: parentCommentUid,
        )
        .orderBy("createdAt");

    return documentList;
  }

  // CREATE COMMENT
  Future createComment(
    UserModel user,
    String animeUid,
    String content,
    int level,
    String? parentCommentUid,
  ) async {
    try {
      AnimeComment newComment = AnimeComment(
        uid: const Uuid().v4(),
        level: level,
        ownerUid: user.uid,
        ownerProfilePic: user.profilePicUrl,
        animeUid: animeUid,
        content: content,
        likedBy: [],
        createdAt: Timestamp.fromDate(DateTime.now()),
        parentCommentUid: parentCommentUid,
        dislikedBy: [],
      );

      await _firebaseFirestore
          .collection('animes')
          .doc(animeUid)
          .collection('comments')
          .doc(newComment.uid)
          .set(AnimeComment.toMap(comment: newComment));

      return;
    } catch (e) {
      debugPrint("Error creating comment: " + e.toString());
      return null;
    }
  }

  // LIKE/DISLIKE COMMENT
  Future likeDislikeComment(
    UserModel user,
    AnimeComment comment,
    bool isLike,
  ) async {
    try {} catch (e) {
      debugPrint("Error liking/disliking comment: " + e.toString());
    }
  }
}
