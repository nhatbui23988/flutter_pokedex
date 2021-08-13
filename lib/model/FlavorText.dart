class FlavorText {
  final String flavorText;

  FlavorText.fromJson(Map<String, dynamic> json)
      : flavorText = json['flavor_text'];

  static List<FlavorText> parseListFlavorFromJson(Map<String, dynamic> json) {
    if (json['flavor_text_entries'] != null) {
      var jsonObject = json['flavor_text_entries'] as List;
      List<FlavorText> flavorTexts =
      jsonObject.map((e) => FlavorText.fromJson(e)).toList();
      return flavorTexts;
    } else
      return [];
  }
}
