import 'package:pokedex_project/model/PokemonStats.dart';

class PokemonDetail {
  final int base_experience;
  final int height;
  final int weight;
  final String name;
  final List<BaseStat> pokemonStat;

  const PokemonDetail(this.base_experience, this.name, this.weight, this.height, this.pokemonStat);

  PokemonDetail.fromJson(Map<String, dynamic> json)
      : base_experience = json['base_experience'],
        height=json['height'],
        weight =json['weight'],
        name =json['name'],
        pokemonStat = BaseStat.parseListBaseFromJson(json);
}
const PokemonDetail _pokemonDetail = PokemonDetail(64, "Pikachu", 10, 70, _listStat);
const List<BaseStat> _listStat = [BaseStat("attack", 64), BaseStat("defense", 64),];