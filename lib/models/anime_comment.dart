import 'package:cloud_firestore/cloud_firestore.dart';

class AnimeComment {
  // UID OF THE COMMENT
  final String uid;
  // LEVEL OF THE COMMENT
  final int level;
  // UID OF THE PARENT COMMENT, IF IS NOT TOP LEVEL
  final String? parentCommentUid;
  // UID OF THE OWNER OF THE COMMENT
  final String ownerUid;
  // UID OF THE ANIME THAT THIS COMMENT BELONGS TO
  final String animeUid;
  // CONTENT OF THE COMMENT
  final String content;
  // LIST OF UIDS OF USERS THAT LIKED THIS COMMENT
  final List<String> likedBy;
  // DATE CREATED
  final Timestamp createdAt;
  // DATE UPDATED
  final Timestamp? updatedAt;

  AnimeComment({
    required this.uid,
    required this.level,
    required this.ownerUid,
    required this.animeUid,
    required this.content,
    required this.likedBy,
    required this.createdAt,
    this.parentCommentUid,
    this.updatedAt,
  });

  static AnimeComment fromMap(Map<String, dynamic> map) => AnimeComment(
        uid: map['uid'],
        level: map['level'],
        ownerUid: map['ownerUid'],
        animeUid: map['animeUid'],
        content: map['content'],
        likedBy: map['likedBy'].cast<String>(),
        createdAt: map['createdAt'],
        parentCommentUid: map['parentCommentUid'],
        updatedAt: map['updatedAt'],
      );

  static toMap({required AnimeComment comment}) {
    return {
      "uid": comment.uid,
      "level": comment.level,
      "ownerUid": comment.ownerUid,
      "animeUid": comment.animeUid,
      "content": comment.content,
      "likedBy": comment.likedBy,
      "createdAt": comment.createdAt,
      "parentCommentUid": comment.parentCommentUid,
      "updatedAt": comment.updatedAt,
    };
  }
}
