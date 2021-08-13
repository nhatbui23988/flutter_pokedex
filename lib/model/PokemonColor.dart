class PokemonColor {
  final String colorName;

  PokemonColor.fromJson(Map<String, dynamic> json)
      : colorName = getColorName(json);

  static String getColorName(Map<String, dynamic> json) {
    var jsonObject = json['color'];
    if (jsonObject['name'] != null)
      return jsonObject['name'];
    else
      return "";
  }
}
