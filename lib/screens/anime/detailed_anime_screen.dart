import 'dart:ffi';

import 'package:anihub_flutter/classes/anime/anime.dart';
import 'package:anihub_flutter/models/user.dart';
import 'package:anihub_flutter/providers/user_provider.dart';
import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/functions.dart';
import 'package:anihub_flutter/widgets/common_single_child_scroll.dart';
import 'package:anihub_flutter/widgets/favorite_button.dart';
import 'package:anihub_flutter/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedAnimeScreen extends StatefulWidget {
  final Anime animeData;

  const DetailedAnimeScreen({
    Key? key,
    required this.animeData,
  }) : super(key: key);

  @override
  State<DetailedAnimeScreen> createState() => _DetailedAnimeScreenState();
}

class _DetailedAnimeScreenState extends State<DetailedAnimeScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    UserModel _currentUser = Provider.of<UserProvider>(context).getUser!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: CommonSingleChildScroll(
        childWidget: Column(
          children: [
            // COVER IMAGE
            Hero(
              tag: "anime_card_cover_${widget.animeData.id}",
              child: Container(
                clipBehavior: Clip.hardEdge,
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: mainOrange,
                      width: 3,
                    ),
                  ),
                ),
                child: CommonNetworkImage(
                    imageUrl: widget.animeData.animeCover.extraLarge),
              ),
            ),
            // ROW (TITLE, LIKES, ADD TO WATCHLIST)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  // TITLE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(
                      widget.animeData.englishTitle ??
                          widget.animeData.romajiTitle ??
                          widget.animeData.nativeTitle!,
                      style: const TextStyle(
                        color: goldenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  // LIKE THING
                  _likeStack(_currentUser),

                  // ADD TO WATCHLIST BUTTON
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _likeStack(UserModel currentUser) {
    bool _isLiked =
        currentUser.favoriteAnimes.contains(widget.animeData.id.toString());

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // LIKE BTN
        FavoriteButton(
            isAnimated: true,
            isFavorited: _isLiked,
            onClick: () async {
              // SET LOADING
              buildLoadingDialog(context);

              // NEED CALL USERPROVIDER FUNCTION.
              await Provider.of<UserProvider>(context, listen: false)
                  .addRemoveFavoriteAnime(!_isLiked, widget.animeData);

              // REMOVE LOADING
              Navigator.pop(context);
            }),
        // FAVORITE COUNT
        Positioned(
          bottom: -23,
          left: 4,
          child: Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: mainGrey, width: 2.0),
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: const Center(child: Text("0")),
          ),
        ),
      ],
    );
  }
}
