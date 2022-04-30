import 'package:anihub_flutter/classes/anime/anime.dart';
import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/utils/constants/anime_constants.dart';
import 'package:anihub_flutter/widgets/anime/anime_card.dart';
import 'package:anihub_flutter/widgets/anime_list_widget.dart';
import 'package:anihub_flutter/widgets/common_single_child_scroll.dart';
import 'package:anihub_flutter/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchInput = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: mainScreenBackground,
      ),
      child: CommonSingleChildScroll(
        childWidget: Column(
          children: [
            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                placeHolder: "Search",
                editingController: _searchController,
                searchBarWidth: double.infinity,
                searchBarHeight: 45.0,
                onSubmit: (value) {
                  setState(() {
                    _searchInput = value;
                  });
                },
                onClear: () {
                  setState(() {
                    _searchInput = "";
                  });
                },
              ),
            ),
            // IF NO SEARCH INPUT, THEN SHOW TEXT AND TRENDING ANIMES
            _searchInput.isEmpty ? _noInputView() : _withInputView(),
          ],
        ),
      ),
    );
  }

  // THIS WILL RETURN A GRID OF ANIME CARDS, AFTER FETCHING GRAPHQL DATA
  Widget _withInputView() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      // height: double.infinity,
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        minHeight: 200,
      ),
      child: Query(
        options: QueryOptions(document: gql(ANIME_LIST_QUERY), variables: {
          "page": PAGE,
          "perPage": 9,
          "search": _searchInput,
          "sort": "POPULARITY_DESC",
        }),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          // ERROR
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          // LOADING
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: mainOrange,
              ),
            );
          }
          // GOOD
          //return Text("Fetched!");

          // SCROLL CONTROLLER FOR FETCHIGN MORE ANIME DATA.
          final ScrollController _scrollController = ScrollController();

          _scrollController.addListener(() {
            if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
              // FETCH MORE
              debugPrint("Fetch More: ");
            }
          });

          return GridView.builder(
            controller: _scrollController,
            itemCount: result.data!["Page"]["media"].length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 0.55,
            ),
            itemBuilder: (BuildContext context, int index) {
              Anime animeData = Anime.fromQueryResultMap(
                  result.data!["Page"]["media"][index]);

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: AnimeCard(
                  animeData: animeData,
                  key: Key("search_anime_card_${animeData.id}"),
                  customWidth: 100,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _noInputView() {
    return Expanded(
        child: Column(
      children: [
        // LITTLE TEXT SAYING WHAT ARE YOU LOOKING FOR
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120.0),
                child: Text(
                  SEARCH_SCREEN_MAIN_TEXT,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // FIND YOUR FAVORITE ANIME
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
                child: Text(
                  SEARCH_SCREEN_SECONDARY_TEXT,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: lightGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
        // TRENDING ANIME
        AnimeListWidget(
          title: "Trending",
          queryVariablesObject: TRENDING_QUERY_VARIABLES,
        ),
      ],
    ));
  }
}
