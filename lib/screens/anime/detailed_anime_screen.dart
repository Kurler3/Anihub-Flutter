import 'package:anihub_flutter/classes/anime/anime.dart';
import 'package:anihub_flutter/utils/colors.dart';
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
      // JUST FOR THE BACK ARROW
      appBar: AppBar(
        backgroundColor: backgroundColor,
      ),
      body: CommonSingleChildScroll(
          childWidget: Column(
        children: [
          // COVER IMAGE
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: CommonNetworkImage(
                imageUrl: widget.animeData.animeCover.extraLarge),
          ),
        ],
      )),
    );
  }
}
