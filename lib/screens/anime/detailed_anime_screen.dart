import 'dart:ffi';

import 'package:anihub_flutter/classes/anime/anime.dart';
import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/widgets/common_elevated_button.dart';
import 'package:anihub_flutter/widgets/common_single_child_scroll.dart';
import 'package:anihub_flutter/widgets/network_image.dart';
import 'package:flutter/material.dart';

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
                  // borderRadius: BorderRadius.only(
                  //   bottomRight: Radius.circular(20),
                  //   bottomLeft: Radius.circular(20),
                  // ),
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
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // LIKE BTN
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          size: 25,
                        ),
                      ),
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
                  ),

                  // ADD TO WATCHLIST BUTTON
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
