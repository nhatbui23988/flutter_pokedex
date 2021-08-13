import 'dart:convert';

import 'package:pokedex_project/model/Pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_project/model/PokemonDetail.dart';
import 'package:pokedex_project/model/PokemonSpecies.dart';

const String urlPokemonName = "https://pokeapi.co/api/v2/pokemon";
const String urlPokemonSpecies = "https://pokeapi.co/api/v2/pokemon-species/";

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

  static String getPokemonSpeciesUrl(int pokemonId) =>
      "$urlPokemonSpecies/$pokemonId";

  static Future<List<PokemonInfo>> fetchPokedex(int offset, int limit) async {
    print("fetchPokedex");
    print("url: ${ApiService.getPokemonNameUrl(offset, limit)}");
    final response =
        await http.get(Uri.parse(ApiService.getPokemonNameUrl(offset, limit)));
    if (response.statusCode == 200) {
      print("#1 statusCode == 200");
      List<PokemonInfo> pokemons =
          PokemonInfo.parseListPokemon(jsonDecode(response.body));
      print("#2 pokemons: ${pokemons.toString()}");
      if (pokemons.isNotEmpty) {
        print("#3 pokemons size : ${pokemons.length}");
        return pokemons;
      } else
        print("#3 pokemons empty");
      return [];
    } else {
      print("#3 Failed to load pokemon");
      throw Exception('Failed to load pokemon');
    }
  }

  static Future<PokemonSpecies?> getPokemonSpicies(int pokemonId) async {
    print("getPokemonSpicies");
    print("url: ${ApiService.getPokemonSpeciesUrl(pokemonId)}");
    final response =
        await http.get(Uri.parse(ApiService.getPokemonSpeciesUrl(pokemonId)));
    if (response.statusCode == 200) {
      print("#1 statusCode == 200");
      PokemonSpecies pokemonSpecies =
          PokemonSpecies.fromJson(jsonDecode(response.body));
      return pokemonSpecies;
    } else {
      return null;
    }
  }
}
