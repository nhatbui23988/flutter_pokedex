import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/model/PokemonDetail.dart';
import 'package:pokedex_project/extension/StringExtension.dart';

class TabPokemonStats extends StatelessWidget {
  final PokemonDetail? _pokemonDetail;

  const TabPokemonStats(this._pokemonDetail);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
          itemCount: _pokemonDetail?.pokemonStat.length ?? 0,
          itemBuilder: (buildContext, index) {
            return _buildStatProgress(
                _pokemonDetail?.pokemonStat[index].statName ?? "",
                _pokemonDetail?.pokemonStat[index].baseStat ?? 1);
          }),
    );
  }

  Widget _buildStatProgress(String statName, int statValue,
      {Color statColor = Colors.redAccent}) {
    double maxBaseStat = 200;
    double spacing = 16;
    double baseHeight = 4;
    double maxWidth = 200;
    double statWidth = 200 / maxBaseStat * statValue;
    Color baseColor = Colors.grey;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: spacing),
          Expanded(
              child: Text(
            statName.capitalize(),
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          SizedBox(width: spacing),
          Text("$statValue"),
          SizedBox(width: spacing),
          Stack(
            children: [
              Container(
                height: baseHeight,
                width: maxWidth,
                color: baseColor,
              ),
              Container(
                height: baseHeight,
                width: statWidth,
                color: statColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
