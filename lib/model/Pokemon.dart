class PokemonInfo {
  final String name;
  final String url;

  const PokemonInfo(this.name, this.url);

  PokemonInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];

  static List<PokemonInfo> parseListPokemon(Map<String, dynamic> json) {
    if (json['results'] != null) {
      var pkmObjsJson = json['results'] as List;
      List<PokemonInfo> _listPokemon =
      pkmObjsJson.map((pkmJson) => PokemonInfo.fromJson(pkmJson)).toList();
      return _listPokemon;
    } else
      return [];
  }
}

const List<PokemonInfo> pokemons = [
  PokemonInfo("Pokemon 1",
      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png"),
  PokemonInfo("Pokemon 2",
      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/002.png"),
  PokemonInfo("Pokemon 3",
      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/003.png"),
  PokemonInfo("Pokemon 4",
      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/004.png"),
  PokemonInfo("Pokemon 5",
      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/005.png"),
  PokemonInfo("Pokemon 6",
      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/006.png"),
  PokemonInfo("Pokemon 7",
      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/007.png"),
  PokemonInfo("Pokemon 8",
      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/008.png"),
  PokemonInfo("Pokemon 9",
      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/009.png"),
  PokemonInfo("Pokemon 10",
      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/010.png"),
];
