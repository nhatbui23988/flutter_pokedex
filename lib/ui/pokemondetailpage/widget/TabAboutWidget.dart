import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/model/PokemonDetail.dart';
import 'package:pokedex_project/model/PokemonSpecies.dart';
import 'package:pokedex_project/extension/StringExtension.dart';

class TabAboutPokemon extends StatefulWidget {
  final PokemonSpecies? _pokemonSpecies;
  final PokemonDetail? _pokemonDetail;

  const TabAboutPokemon(this._pokemonSpecies, this._pokemonDetail);

  @override
  TabAboutPokemonState createState() => TabAboutPokemonState();

}

class TabAboutPokemonState extends State<TabAboutPokemon>{

  PokemonSpecies? get _pokemonSpecies => widget._pokemonSpecies;
  PokemonDetail? get _pokemonDetail => widget._pokemonDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        // primary: false,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildDescriptionText(),
          _buildBaseStats(),
          _buildBaseInformation(),
          _buildTrainingInfo()
        ],
      ),
    );
  }

  Widget _buildDescriptionText() => Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    child: _pokemonSpecies == null? Text("??????"): Text(
      "\"${_pokemonSpecies?.listFlavorText[0].flavorText.replaceAll(RegExp("\n"), " ") ?? ""}\"",
      style: TextStyle(
          fontSize: 14,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.normal),
    ),
    decoration: ShapeDecoration(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.grey[200]),
  );

  Widget _buildBaseStats() => AnimatedContainer(
    height: null,
    duration: Duration(milliseconds: 500),
    margin: EdgeInsets.symmetric(vertical: 6),
    child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _pokemonDetail?.pokemonStat.length ?? 0,
        itemBuilder: (buildContext, index) {
          return _buildStatProgress(
              _pokemonDetail?.pokemonStat[index].statName ?? "",
              _pokemonDetail?.pokemonStat[index].baseStat ?? 1);
        }),
  );

  Widget _buildBaseInformation() => Container(
    margin: EdgeInsets.symmetric(vertical: 12),
    padding: EdgeInsets.all(12),
    decoration: ShapeDecoration(
        shadows: [
          BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 12,
              color: Colors.grey,
              spreadRadius: 1)
        ],
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white),
    alignment: Alignment.centerLeft,
    child: DataTable(
      headingRowHeight: 24,
      dataRowHeight: 24,
      dividerThickness: 0,
      columns: [
        DataColumn(
            label: Text(
              "Height",
              style: TextStyle(color: Colors.grey),
            )),
        DataColumn(
            label: Text(
              "Weight",
              style: TextStyle(color: Colors.grey),
            )),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Center(
            child: Text("${(_pokemonDetail?.height ?? 0)}\"",
                style: TextStyle(color: Colors.black)),
          )),
          DataCell(Center(
            child: Text("${_pokemonDetail?.weight ?? 0} lbs",
                style: TextStyle(color: Colors.black)),
          ))
        ]),
      ],
    ),
  );

  Widget _buildTrainingInfo() => Container(
    margin: EdgeInsets.only(top: 6),
    alignment: Alignment.topLeft,
    child: Column(
      children: [
        Text("Training",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Row(
          children: [
            Text(
              "Base Experience",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 12),
            Text(
              "${_pokemonDetail?.baseExperience ?? ""}",
              style: TextStyle(fontWeight: FontWeight.w400),
            )
          ],
        )
      ],
    ),
  );

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
