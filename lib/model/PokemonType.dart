class PokemonType {
  final int slot;
  final String name;

  const PokemonType(this.slot, this.name);

  PokemonType.fromJson(Map<String, dynamic> json)
      : slot = json['slot'],
        name = getTypeName(json);

  static String getTypeName(Map<String, dynamic> json) {
    if (json['type'] != null) {
      var typeObject = json['type'];
      return typeObject['name'];
    } else
      return "";
  }

  static List<PokemonType> getListType(Map<String, dynamic> json) {
    if (json['types'] != null) {
      var jsonObject = json['types'] as List;
      List<PokemonType> listType =
          jsonObject.map((e) => PokemonType.fromJson(e)).toList();
      return listType;
    } else
      return [];
  }
}
