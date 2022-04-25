import 'package:anihub_flutter/classes/anime/anime_airing_schedule.dart';
import 'package:anihub_flutter/classes/anime/anime_character.dart';
import 'package:anihub_flutter/classes/anime/anime_cover.dart';
import 'package:anihub_flutter/classes/anime/anime_staff.dart';
import 'package:anihub_flutter/classes/anime/anime_studio.dart';
import 'package:anihub_flutter/classes/anime/anime_tag.dart';
import 'package:anihub_flutter/classes/anime/anime_trailer.dart';

class Anime {
  // ID OF ANIME TO LATER STORE IN FAVORITES OF USER
  String id;

  // TITLE
  String englishTitle;
  String nativeTitle;
  String romajiTitle;

  // TYPE (ANIME OR MANGA)
  String type;

  // STATUS (finished, releasing...)
  String status;

  // Description
  String? description;

  // Start Date
  String startDate;

  // End Date
  String endDate;

  // Season (winter, spring, summer, fall)
  String season;

  // Season year
  int seasonYear;

  // Episodes anime has when complete
  int? episodes;

  // Duration of each episode
  int? durationEpisode;

  // Country code of where it was created
  String? countryOriginCode;

  // Trailer
  AnimeTrailer? animeTrailer;

  // Last updated at
  int? updatedAt;

  // Cover image
  AnimeCover? animeCover;

  // Banner image
  String animeBanner;

  // GENRES
  List<String> genres;

  // AVERAGE SCORE (use for stars later)
  int averageScore;

  // Popularity
  int? popularity;

  // Trending (amount of related activity in the past hour)
  int? trending;

  // Number of ppl who favorited it.
  int? favourites;

  // TAGS (to maybe filter later)
  List<AnimeTag>? tags;

  // Characters
  List<AnimeCharacter>? characters;

  // Staff
  List<AnimeStaff>? staff;

  // Studios
  List<AnimeStudio>? studios;

  // is adult
  bool isAdult;

  AiringSchedule? nextAiringEpisode;

  Anime({
    required this.id,
    required this.englishTitle,
    required this.nativeTitle,
    required this.romajiTitle,
    required this.type,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.season,
    required this.seasonYear,
    required this.animeBanner,
    required this.genres,
    required this.averageScore,
    required this.isAdult,
  });
}
