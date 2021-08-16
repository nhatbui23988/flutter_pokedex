import 'dart:convert';

import 'package:pokedex_project/model/FlavorText.dart';

class PokemonSpecies {
  final int baseHappiness;
  final int captureRate;
  final String name;
  final List<String> pkmGroupName;
  final List<FlavorText> listFlavorText;

  PokemonSpecies.fromJson(Map<String, dynamic> json)
      : baseHappiness = json['base_happiness'],
        captureRate = json['capture_rate'],
        name = json['name'],
        pkmGroupName = getGroupName(json),
        listFlavorText = FlavorText.parseListFlavorFromJson(json);

  static List<String> getGroupName(Map<String, dynamic> json) {
    if (json['egg_groups'] != null) {
      var jsonObject = json['egg_groups'] as List;
      List<String> groupName = jsonObject.map((e) => e['name'] as String).toList();
      return groupName;
    } else
      return [];
  }
}
