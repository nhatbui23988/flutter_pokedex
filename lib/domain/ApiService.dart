import 'dart:convert';

import 'package:pokedex_project/model/Pokemon.dart';
import 'package:http/http.dart' as http;

const String urlPokemonName = "https://pokeapi.co/api/v2/pokemon";
const String urlPokemonSpecies = "https://pokeapi.co/api/v2/pokemon-species/1/";

const String urlPokemonImage =
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork";
//
const String paramsOffset = "offset";
const String paramsLimit = "limit";
const String paramsPrefixPng = ".png";

class ApiService {
  static String getPokemonNameUrl(int offset, int limit) =>
      "$urlPokemonName/?$paramsOffset=$offset&$paramsLimit=$limit";

  static String getPokemonImageUrl(int index) =>
      "$urlPokemonImage/$index$paramsPrefixPng";

  static Future<List<PokemonInfo>> fetchPokedex(int offset, int limit) async {
    print("fetchPokedex");
    final response =
        await http.get(Uri.parse(ApiService.getPokemonNameUrl(offset, limit)));
    if (response.statusCode == 200) {
      print("#1 statusCode == 200");
      List<PokemonInfo> pokemons = PokemonInfo.parseListPokemon(jsonDecode(response.body));
      print("#2 pokemons: ${pokemons.toString()}");
      if (pokemons.isNotEmpty) {
        print("#3 pokemons size : ${pokemons.length}");
        return pokemons;
      } else
        return [];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load pokemon');
    }
  }
}
