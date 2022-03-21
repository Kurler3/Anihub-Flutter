import 'package:anihub_flutter/classes/watching_anime.dart';

class UserModel {
  // IDENTIFICATION
  String uid;
  String email;

  // DISPLAY
  String username;
  String displayUsername;

  String profilePicUrl;
  String backgroundPicUrl;

  // SOCIAL URLS
  String? instagramUrl;
  String? twitterUrl;
  String? facebookUrl;

  // SOCIAL LISTS
  List<String> followers;
  List<String> following;

  // ANIME LISTS
  List<String> favoriteAnimes;
  List<String> watchList;
  List<WatchingAnime> currentlyWatching;
  List<String> finishedWatching;

  //TODO ADD USER SETTINGS LATER

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilePicUrl,
    required this.backgroundPicUrl,
    required this.displayUsername,

    // SOCIAL MEDIA
    this.instagramUrl,
    this.twitterUrl,
    this.facebookUrl,

    // LISTS
    required this.followers,
    required this.following,
    required this.favoriteAnimes,
    required this.watchList,
    required this.currentlyWatching,
    required this.finishedWatching,
  });

  static Map<String, dynamic> toMap({required UserModel userData}) {
    return {
      "uid": userData.uid,
      "username": userData.username,
      "displayUsername": userData.displayUsername,
      "email": userData.email,
      "profilePicUrl": userData.profilePicUrl,
      "backgroundPicUrl": userData.backgroundPicUrl,
      "followers": userData.followers,
      "following": userData.following,
      "favoriteAnimes": userData.favoriteAnimes,
      "watchList": userData.watchList,
      "currentlyWatching": userData.watchList,
      "finishedWatching": userData.finishedWatching,
    };
  }

  static UserModel fromMap({required Map<String, dynamic> map}) => UserModel(
        uid: map["uid"],
        username: map['username'],
        displayUsername: map["displayUsername"],
        email: map['email'],
        profilePicUrl: map['profilePicUrl'],
        backgroundPicUrl: map["backgroundPicUrl"],
        followers: map["followers"],
        following: map["following"],
        favoriteAnimes: map["favoriteAnimes"],
        watchList: map["watchList"],
        currentlyWatching: map["currentlyWatching"],
        finishedWatching: map["finishedWatching"],
      );
}
