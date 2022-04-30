import 'package:anihub_flutter/utils/constants/anime_constants.dart';

// GIVEN A DateTime GET THE CORRESPONDING ANIME SEASON
AnimeSeason getAnimeSeason(DateTime dateTime) {
  int month = dateTime.month;

  if (month >= 3 && month <= 5) {
    return AnimeSeason.spring;
  } else if (month >= 6 && month <= 8) {
    return AnimeSeason.summer;
  } else if (month >= 9 && month <= 11) {
    return AnimeSeason.fall;
  } else {
    return AnimeSeason.winter;
  }
}
