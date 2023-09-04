class Trip {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String type;
  String backgroundImageUrl;

  Trip({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.backgroundImageUrl,
  });
}
