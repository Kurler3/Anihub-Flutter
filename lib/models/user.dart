class UserModal {
  String uid;
  String username;
  String email;
  String profilePicUrl;
  String backgroundPicUrl;
  List<String> followers;
  List<String> following;

  // LATER ADD SAVED ANIME AND WHATEVER ELSE

  UserModal({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilePicUrl,
    required this.backgroundPicUrl,
    required this.followers,
    required this.following,
  });

  static Map<String, dynamic> toMap({required UserModal userData}) {
    return {
      "uid": userData.uid,
      "username": userData.username,
      "email": userData.email,
      "profilePicUrl": userData.profilePicUrl,
      "backgroundPicUrl": userData.backgroundPicUrl,
      "followers": userData.followers,
      "following": userData.following,
    };
  }

  static UserModal fromMap({required Map<String, dynamic> map}) => UserModal(
      uid: map["uid"],
      username: map['username'],
      email: map['email'],
      profilePicUrl: map['profilePicUrl'],
      backgroundPicUrl: map["backgroundPicUrl"],
      followers: map["followers"],
      following: map["following"]);
}
