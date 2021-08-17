import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/model/PokemonDetail.dart';
import 'package:pokedex_project/model/PokemonSpecies.dart';

class TabAboutPokemon extends StatelessWidget {
  final PokemonSpecies? _pokemonSpcies;
  final PokemonDetail? _pokemonDetail;

  const TabAboutPokemon(this._pokemonSpcies, this._pokemonDetail);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: ListView(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildDescriptionText(),
          _buildBasePokemonData(),
          _buildTrainingInfo()
        ],
      ),
    );
  }

  Widget _buildDescriptionText() => Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Text(
          "\"${_pokemonSpcies?.listFlavorText[0].flavorText.replaceAll(RegExp("\n"), " ") ?? ""}\"",
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

  Widget _buildBasePokemonData() => Container(
        margin: EdgeInsets.symmetric(vertical: 20),
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
}
