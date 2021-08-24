import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/model/PokemonDetail.dart';
import 'package:pokedex_project/ui/pokemondetailpage/widget/PokemonDetailBodyWidget.dart';

const int MAX_POKEMON = 1000;
const int INCREASE_RANGE = 5;

class PokemonDetailPage extends StatefulWidget {
  final int _pokemonId;
  final PokemonDetail? _pokemonDetail;

  const PokemonDetailPage(this._pokemonId, this._pokemonDetail);

  @override
  PokemonDetailState createState() => PokemonDetailState();
}

class PokemonDetailState extends State<PokemonDetailPage> {
  late PageController _pageController;

  int get _pokemonId => widget._pokemonId;

  int _currentPageIndex = 0;

  late List<int> _listId ;

  // PokemonDetail? get _pokemonSearchResult => widget._pokemonDetail;

  @override
  void initState() {
    _listId = List<int>.generate(MAX_POKEMON, (index) => index + 1);
    _currentPageIndex = _pokemonId-1;
    _pageController = PageController(initialPage: _currentPageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: PageView(
          onPageChanged: onPageChanged,
          controller: _pageController,
          children: _listId
              .map((pokemonId) => PokemonDetailBodyWidget(
                  pokemonId, isAllowVisibleContent(pokemonId)))
              .toList(),
        ));
  }

  bool isAllowVisibleContent(int pokemonId) {
    return (_currentPageIndex + 1 == pokemonId ||
        _currentPageIndex + 1  == pokemonId + 1 ||
        _currentPageIndex + 1 == pokemonId - 1);
  }

  void onPageChanged(int index){
    print("onPageChanged");
    print("#1 index: $index");
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
