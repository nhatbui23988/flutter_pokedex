import 'package:pokedex_project/model/PokemonStats.dart';

class PokemonDetail {
  final int _base_experience;
  final int _height;
  final int _weight;
  final String _name;
  final List<BaseStat> _pokemonStat;

  const PokemonDetail(this._base_experience, this._name, this._weight, this._height, this._pokemonStat);

  PokemonDetail.fromJson(Map<String, dynamic> json)
      : _base_experience = json['base_experience'],
        _height=json['height'],
        _weight =json['weight'],
        _name =json['name'],
        _pokemonStat = BaseStat.parseListBaseFromJson(json);
}
const PokemonDetail _pokemonDetail = PokemonDetail(64, "Pikachu", 10, 70, _listStat);
const List<BaseStat> _listStat = [BaseStat("attack", 64), BaseStat("defense", 64),];