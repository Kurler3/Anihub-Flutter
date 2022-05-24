class AnimeBackend {
  final String uid;
  final List<String> favoritedBy;
  final String? englishTitle;
  final String? romajiTitle;
  final String nativeTitle;
  final String status;

  AnimeBackend({
    required this.uid,
    required this.favoritedBy,
    required this.nativeTitle,
    required this.status,
    this.englishTitle,
    this.romajiTitle,
  });

  static AnimeBackend fromMap(Map<String, dynamic> map) => AnimeBackend(
        uid: map['uid'],
        favoritedBy: map['favoritedBy'].cast<String>(),
        nativeTitle: map['nativeTitle'],
        status: map['status'],
        englishTitle: map['englishTitle'],
        romajiTitle: map['romajiTitle'],
      );

  static toMap({required AnimeBackend animeBackend}) {
    return {
      "uid": animeBackend.uid,
      "favoritedBy": animeBackend.favoritedBy,
      "englishTitle": animeBackend.englishTitle,
      "romajiTitle": animeBackend.romajiTitle,
      "nativeTitle": animeBackend.nativeTitle,
      "status": animeBackend.status,
    };
  }
}
