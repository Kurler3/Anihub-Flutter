import 'package:anihub_flutter/back_end_methods/database_methods.dart';
import 'package:anihub_flutter/models/anime_comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AnimeBackEndComments extends ChangeNotifier {
  // DEFINE THE COMMENTS ARRAY
  final List<AnimeComment> _commentsList = [];

  // GET COMMENTS LIST
  get getCommentsList => _commentsList;

  // FETCH COMMENTS
  fetchNextComments(
      String animeUid, int level, String? parentCommentUid) async {
    DocumentSnapshot? startAfterDoc = await DatabaseMethods()
        .getLastAnimeCommentDoc(animeUid, level, parentCommentUid);

    // MAKE DB CALL
    QuerySnapshot<Map<String, dynamic>>? commentsQuerySnap =
        await DatabaseMethods()
            .getAnimeComments(animeUid, level, parentCommentUid, startAfterDoc);

    if (commentsQuerySnap != null) {
      _commentsList.addAll(commentsQuerySnap.docs.map(
          (commentDocSnap) => AnimeComment.fromMap(commentDocSnap.data())));

      notifyListeners();
    }
  }

  // CLEAR COMMENTS
  clearComments() {
    _commentsList.clear();
    notifyListeners();
  }
}
