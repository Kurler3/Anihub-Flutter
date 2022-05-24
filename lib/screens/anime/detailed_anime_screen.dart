import 'dart:ffi';

import 'package:anihub_flutter/back_end_methods/database_methods.dart';
import 'package:anihub_flutter/classes/anime/anime.dart';
import 'package:anihub_flutter/models/user.dart';
import 'package:anihub_flutter/providers/user_provider.dart';
import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/functions.dart';
import 'package:anihub_flutter/widgets/common_single_child_scroll.dart';
import 'package:anihub_flutter/widgets/favorite_button.dart';
import 'package:anihub_flutter/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 50,
                    // constraints: BoxConstraints(
                    //   maxWidth: MediaQuery.of(context).size.width * 0.4,
                    //   maxHeight: 50,
                    // ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          widget.animeData.englishTitle ??
                              widget.animeData.romajiTitle ??
                              widget.animeData.nativeTitle!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: goldenColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // LIKE THING
                  _likeStack(_currentUser),
                  // FILL UP THE REMAINING SPACE
                  const Spacer(),
                  // ADD TO WATCHLIST BUTTON
                  _watchListBtn(_currentUser),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _watchListBtn(UserModel currentUser) {
    bool isInWatchlist =
        currentUser.watchList.contains(widget.animeData.id.toString());

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      width: 150,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () async {
          // SET LOADING
          buildLoadingDialog(context);

          await Provider.of<UserProvider>(context, listen: false)
              .addRemoveFromWatchlist(!isInWatchlist, widget.animeData);

          // REMOVE LOADING
          Navigator.pop(context);
        },
        label: Center(
          child: Text(
            isInWatchlist ? "Remove from watchlist" : "Add to watchlist",
            textAlign: TextAlign.center,
          ),
        ),
        icon: Icon(isInWatchlist ? Icons.remove_circle : Icons.add),
        // DECORATION :)
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              isInWatchlist ? Colors.red : Colors.blue),
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
            child: FutureBuilder(
              future: DatabaseMethods().getAnimeFavCount(widget.animeData),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.hasData) {
                    final int count = snapshot.data!;

                    return Center(
                      child: Text(count.toString()),
                    );
                  }
                } else if (snapshot.hasData) {
                  final int count = snapshot.data!;

                  return Center(
                    child: Text(count.toString()),
                  );
                }

                // LOADING
                return const Center(
                  child: SpinKitDualRing(
                    color: mainOrange,
                    size: 10.0,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
