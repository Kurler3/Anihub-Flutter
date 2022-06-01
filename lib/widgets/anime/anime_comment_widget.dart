import 'package:anihub_flutter/models/anime_comment.dart';
import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/widgets/network_image.dart';
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
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: mainGrey),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 2.0,
        ),
        child: Column(
          children: [
            // PROFILE PIC AND CONTENT
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(146, 109, 109, 109),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  // PROFILE PIC
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CommonNetworkImage(
                        imageUrl: widget.animeComment.ownerProfilePic,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // CONTENT
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.animeComment.content,
                    ),
                  ),
                ],
              ),
            ),

            // LIKE + DISLIKE BUTTONS + REPLY BTN + FOLLOW BTN
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _commentButtons(),
                // FOLLOW BTN
                TextButton(
                  onPressed: () {},
                  child: Text("Follow"),
                ),

                // EDIT BTN IF CURRENT USER ID IS SAME AS THE COMMENT OWNER ID.
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _commentButtons() {
    return Row(
      children: [
        // LIKE BTN
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_upward,
            size: COMMENT_WIDGET_ICON_SIZE,
          ),
        ),
        // LIKED BY - DISLIKED BY
        Text((widget.animeComment.likedBy.length -
                widget.animeComment.dislikedBy.length)
            .toString()),
        // DISLIKED BTN
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_downward,
            size: COMMENT_WIDGET_ICON_SIZE,
          ),
        ),
        // REPLY BTN
        IconButton(
          onPressed: () {
            // NAVIGATE TO SPECIFIC COMMENT SCREEN
          },
          icon: Icon(
            Icons.mode_comment_outlined,
            size: COMMENT_WIDGET_ICON_SIZE,
          ),
        ),
      ],
    );
  }
}
