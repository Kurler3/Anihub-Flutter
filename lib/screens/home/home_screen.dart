import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/utils/constants/anime_constants.dart';
import 'package:anihub_flutter/widgets/anime_list_widget.dart';
import 'package:anihub_flutter/widgets/common_single_child_scroll.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonSingleChildScroll(
      childWidget: Container(
        decoration: const BoxDecoration(
          gradient: mainScreenBackground,
        ),
        child: Column(
          children: [
            // TODO ADD THE WATCHING ONES LATER :)

            // POPULAR
            const AnimeListWidget(
              title: "Popular",
              queryVariablesObject: POPULAR_QUERY_VARIABLES,
            ),

            // TOP AIRING
            AnimeListWidget(
              title: "Top Airing",
              queryVariablesObject: TOP_AIRING_QUERY_VARIABLES,
            ),
          ],
        ),
      ),
    );
  }
}
