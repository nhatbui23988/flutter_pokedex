import 'package:pokedex_project/model/PokemonStats.dart';
import 'package:pokedex_project/model/PokemonType.dart';

class PokemonDetail {
  final int baseExperience;
  final int height;
  final int weight;
  final String name;
  final List<BaseStat> pokemonStat;
  final List<PokemonType> listType;

  const PokemonDetail(this.baseExperience, this.name, this.weight, this.height,
      this.pokemonStat, this.listType);

  PokemonDetail.fromJson(Map<String, dynamic> json)
      : baseExperience = json['base_experience'],
        height = json['height'],
        weight = json['weight'],
        name = json['name'],
        pokemonStat = BaseStat.parseListBaseFromJson(json),
        listType = PokemonType.getListType(json);
}

const PokemonDetail _pokemonDetail =
    PokemonDetail(64, "Pikachu", 10, 70, _listStat, _listType);
const List<BaseStat> _listStat = [
  BaseStat("attack", 64),
  BaseStat("defense", 64),
];
const List<PokemonType> _listType = [
  PokemonType(1, "posion"),
];
