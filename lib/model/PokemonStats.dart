import 'dart:convert';

class BaseStat {
  final int baseStat;
  final String statName;

  const BaseStat(this.statName, this.baseStat);

  BaseStat.fromJson(Map<String, dynamic> json)
      : baseStat = json['base_stat'],
        statName = parseFromJson(json);

  static String parseFromJson(Map<String, dynamic> json) {
    if (json['stat'] != null) {
      var jsonName = json['stat'];
      return jsonName['name'];
    } else
      return "";
  }

  static List<BaseStat> parseListBaseFromJson(Map<String, dynamic> json) {
    if (json['stats'] != null) {
      var jsonObject = json['stats'] as List;
      List<BaseStat> listStat =
          jsonObject.map((jsonStat) => BaseStat.fromJson(jsonStat)).toList();
      return listStat;
    } else
      return [];
  }
}
