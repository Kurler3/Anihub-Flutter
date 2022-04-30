import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/utils/constants/anime_constants.dart';
import 'package:anihub_flutter/widgets/anime_list_widget.dart';
import 'package:anihub_flutter/widgets/common_single_child_scroll.dart';
import 'package:anihub_flutter/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

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
              ),
            ),
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
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
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
        ),
      ),
    );
  }
}
