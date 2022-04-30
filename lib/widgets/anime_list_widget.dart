import 'package:anihub_flutter/classes/anime/anime.dart';
import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants/anime_constants.dart';
import 'package:anihub_flutter/widgets/anime/anime_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AnimeListWidget extends StatefulWidget {
  // TITLE
  final String title;

  // VARIABLES OBJECT TO PASS INTO GRAPHQL QUERY OPTIONS
  final Map<String, dynamic> queryVariablesObject;

  const AnimeListWidget({
    Key? key,
    required this.title,
    required this.queryVariablesObject,
  }) : super(key: key);

  @override
  State<AnimeListWidget> createState() => _AnimeListWidgetState();
}

class _AnimeListWidgetState extends State<AnimeListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TITLE
                Padding(
                  padding: const EdgeInsets.only(
                      left: ANIME_LIST_TITLE_PADDING_LEFT),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // SEE ALL BUTTON (Redirects to another screen with a search bar and more anime cards)
                InkWell(
                  onTap: () {
                    debugPrint("See all tapped :)))");
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ANIME_LIST_SEE_MORE_TEXT,
                      style: TextStyle(
                        color: mainOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              // clipBehavior: Clip.none,
              constraints: const BoxConstraints(
                minWidth: double.infinity,
                minHeight: 200,
              ),
              child: Query(
                options: QueryOptions(
                  document: gql(ANIME_LIST_QUERY),
                  variables: widget.queryVariablesObject,
                ),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  // EXCEPTION
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  // IS LOADING
                  if (result.isLoading) {
                    return _displayLoadingList();
                  }

                  return _displayList(result.data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayList(Map<String, dynamic>? data) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: data?["Page"]["pageInfo"]["perPage"],
        itemBuilder: (BuildContext context, int index) {
          Anime animeData =
              Anime.fromQueryResultMap(data?["Page"]["media"][index]);

          return AnimeCard(
            animeData: animeData,
            key: Key("anime_card_${animeData.id}"),
          );
        });
  }

  // LOADING ANIME LIST
  Widget _displayLoadingList() {
    return const Center(
      child: Text("Loading..."),
    );
  }
}
