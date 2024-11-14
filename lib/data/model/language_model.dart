class Language {
  final String name;
  final String date;
  final String description;
  final String cycles;
  final String startDate;
  final String endDate;
  final List<String> prices;
  final List<String> locations;
  final List<String> logos;

  Language({
    required this.name,
    required this.date,
    required this.description,
    required this.cycles,
    required this.startDate,
    required this.endDate,
    required this.prices,
    required this.locations,
    required this.logos,
  });
}
