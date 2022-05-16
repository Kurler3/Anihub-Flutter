// CATEGORY ENUM

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:anihub_flutter/utils/functions/anime_functions.dart';

enum AnimeCategory {
  popular,
  favorite,
  topAiring,
  seasonal,
}

enum AnimeSeason {
  winter,
  spring,
  summer,
  fall,
}

// PAGE NUMBER
const int PAGE = 1;

// PER PAGE
const int PER_PAGE = 8;

// PADDING LEFT ANIME LIST TEXT
const double ANIME_LIST_TITLE_PADDING_LEFT = 2.0;

const String ANIME_LIST_SEE_MORE_TEXT = "See all >";

const double ANIME_CARD_DIMENSIONS = 130.0;

// POPULAR QUERY VARIABLES

const POPULAR_QUERY_VARIABLES = {
  "page": PAGE,
  "perPage": PER_PAGE,
  "sort": "POPULARITY_DESC",
};

// TOP AIRING QUERY VARIABLES
Map<String, dynamic> TOP_AIRING_QUERY_VARIABLES = {
  "page": PAGE,
  "perPage": PER_PAGE,
  "sort": "POPULARITY_DESC",
  "season":
      getAnimeSeason(DateTime.now()).toString().toUpperCase().split(".")[1],
  "seasonYear": DateTime.now().year,
};

// TRENDING QUERY VARIABLES
Map<String, dynamic> TRENDING_QUERY_VARIABLES = {
  "page": PAGE,
  "perPage": PER_PAGE,
  "sort": "TRENDING_DESC",
};

// MOST FAVOURITED QUERY VARIABLES

// COMMON QUERY STRING
const String ANIME_LIST_QUERY = """
    query (\$page: Int, \$perPage: Int, \$sort: [MediaSort], \$season: MediaSeason, \$seasonYear: Int, \$search: String) {
      Page(page: \$page, perPage: \$perPage) {
        pageInfo {
          total
          perPage
          currentPage
          lastPage
          hasNextPage
        }
        media(type: ANIME, sort: \$sort, season: \$season, seasonYear: \$seasonYear, search: \$search) {
          id
          title {
            romaji 
            english
            native
          }
          status
          season
          seasonYear
          coverImage {
            extraLarge
            large
            medium
            color
          }
          genres
          averageScore
          isAdult
        }
      }
    }
  """;
