class AiringSchedule {
  String id;
  // TIME EPISODE AIRS AT
  int airingAt;

  int timeUntilAiring;

  // NUMBER OF EPISODE THAT IS GOING TO BE AIRING
  int episode;

  // ANIME ID ASSOCIATED WITH THIS EPISODE
  int mediaId;

  AiringSchedule({
    required this.id,
    required this.airingAt,
    required this.timeUntilAiring,
    required this.mediaId,
    required this.episode,
  });
}
