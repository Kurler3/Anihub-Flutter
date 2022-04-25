import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants/anime_constants.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AnimeListWidget extends StatefulWidget {
  final String title;

  // FROM ENUM CATEGORY
  final ANIME_CATEGORY category;

  const AnimeListWidget({
    Key? key,
    required this.title,
    required this.category,
  }) : super(key: key);

  @override
  State<AnimeListWidget> createState() => _AnimeListWidgetState();
}

class _AnimeListWidgetState extends State<AnimeListWidget> {
  String popularQuery = """
    query (\$page: Int, \$perPage: Int, \$search: String) {
      Page(page: \$page, perPage: \$perPage) {
        pageInfo {
          total
          perPage
        }
        media(search: \$search, type: ANIME, sort: POPULARITY_DESC) {
          id
          title {
            romaji 
            english
            native
          }
        }
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(popularQuery),
        variables: const {
          "page": 1,
          "perPage": 5,
          "search": "My Hero Academia",
        },
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        // EXCEPTION
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        // IS LOADING
        if (result.isLoading) {
          return const Text("Loading...");
        }

        // SEE DATA FETCHED
        debugPrint("Animes: " + result.data.toString());

        return _displayList(result.data);
      },
    );
  }

  Widget _displayList(Map<String, dynamic>? data) {
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
            Expanded(
              child: ListView.builder(
                  itemCount: data?["Page"]["pageInfo"]["perPage"],
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                        data?["Page"]["media"][index]["title"]["english"]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
