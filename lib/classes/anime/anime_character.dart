class CharacterName {
  String full;
  String native;

  CharacterName({required this.full, required this.native});
}

class AnimeCharacter {
  String id;
  CharacterName name;
  String image;
  String description;
  String gender;
  String age;
  String characterWebsite;
  int favourites;

  AnimeCharacter({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.gender,
    required this.age,
    required this.characterWebsite,
    required this.favourites,
  });
}
