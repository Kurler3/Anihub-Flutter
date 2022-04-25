import 'package:anihub_flutter/classes/anime/anime_character.dart';

class AnimeStaffName {
  String full;
  String native;

  AnimeStaffName({required this.full, required this.native});
}

class AnimeStaffImage {
  String large;
  String medium;

  AnimeStaffImage({required this.large, required this.medium});
}

class AnimeStaff {
  String id;
  AnimeStaffName name;
  String primaryLanguage;
  AnimeStaffImage image;
  String description;
  String gender;
  int age;
  String siteUrl;
  List<AnimeCharacter> charactersActed;

  AnimeStaff({
    required this.id,
    required this.name,
    required this.primaryLanguage,
    required this.image,
    required this.description,
    required this.gender,
    required this.age,
    required this.siteUrl,
    required this.charactersActed,
  });
}
