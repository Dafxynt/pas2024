class PostModel {
  final int idTeam;
  final String strTeam;
  final String strLeague;
  final String strLogo;

  PostModel({
    required this.idTeam,
    required this.strTeam,
    required this.strLeague,
    required this.strLogo,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      idTeam: json['idTeam'],
      strTeam: json['strTeam'],
      strLeague: json['strLeague'],
      strLogo: json['strLogo'],
    );
  }
}
