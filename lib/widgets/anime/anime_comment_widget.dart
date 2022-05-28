import 'package:anihub_flutter/models/anime_comment.dart';
import 'package:flutter/material.dart';

class AnimeCommentWidget extends StatefulWidget {
  final AnimeComment animeComment;

  const AnimeCommentWidget({
    Key? key,
    required this.animeComment,
  }) : super(key: key);

  @override
  State<AnimeCommentWidget> createState() => _AnimeCommentWidgetState();
}

class _AnimeCommentWidgetState extends State<AnimeCommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Text(widget.animeComment.content),
    );
  }
}
