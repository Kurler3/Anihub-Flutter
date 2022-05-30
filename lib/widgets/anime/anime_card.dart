import 'package:anihub_flutter/classes/anime/anime.dart';
import 'package:anihub_flutter/screens/anime/detailed_anime_screen.dart';
import 'package:anihub_flutter/utils/constants/anime_constants.dart';
import 'package:anihub_flutter/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimeCard extends StatelessWidget {
  final Anime animeData;
  final double? customWidth;

  const AnimeCard({
    Key? key,
    required this.animeData,
    this.customWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: customWidth ?? ANIME_CARD_DIMENSIONS,
      margin: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) =>
                  DetailedAnimeScreen(animeData: animeData))));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // COVER
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 180,
              child: Hero(
                tag: "anime_card_cover_${animeData.id}",
                child: CommonNetworkImage(
                  imageUrl: animeData.animeCover.extraLarge,
                  //TODO WILL PROB CHANGE LATER TO A CUSTOM LOADING BUILDER
                  loadingContainerHeight: ANIME_CARD_DIMENSIONS,
                  loadingContainerWidth: ANIME_CARD_DIMENSIONS,
                ),
              ),
            ),

            // Space between cover and title
            const SizedBox(height: 5),

            // Title in english
            Expanded(
              child: Text(
                animeData.englishTitle ??
                    animeData.romajiTitle ??
                    animeData.nativeTitle!,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),

            // SEASON AND EPISODE (if showing watching)
          ],
        ),
      ),
    );
  }
}
