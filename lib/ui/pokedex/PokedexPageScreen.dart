import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/domain/ApiService.dart';
import 'package:pokedex_project/extension/StringExtension.dart';
import 'package:pokedex_project/model/Pokemon.dart';
import 'package:pokedex_project/utils/image_utils.dart';

class PokedexPage extends StatefulWidget {
  @override
  PokedexPageState createState() => PokedexPageState();
}

const int itemsPerPage = 50;

class PokedexPageState extends State<PokedexPage>
    with TickerProviderStateMixin {
  int _offset = 0;
  List<PokemonInfo> _pokemonList = [];

  ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _canLoadMore = false;
  int _endReachedThreshold = 200;

  @override
  void initState() {
    _scrollController.addListener(onScroll);
    super.initState();
    getPokemonData();
  }

  void onScroll() {
    print("onScroll");
    print("#1 hasClients: ${_scrollController.hasClients}");
    print("#2 _isLoading: $_isLoading");
    print("#3 _canLoadMore $_canLoadMore");
    if (!_scrollController.hasClients || _isLoading || !_canLoadMore) return;
    final thresholdReached =
        _scrollController.position.extentAfter < _endReachedThreshold;
    print("#4 position.extentAfter: ${_scrollController.position.extentAfter}");
    print("#5 thresholdReached $thresholdReached");
    if (thresholdReached) {
      _isLoading = true;
      getPokemonData();
    }
  }

  void getPokemonData() async {
    print("getPokemonData");
    print("#1 fetchPokedex offset: $_offset, itemPerpage: $itemsPerPage");
    List<PokemonInfo> list =
        await ApiService.fetchPokedex(_offset, itemsPerPage);
    print("#2 list.length ${list.length}");
    _canLoadMore = !(list.length < itemsPerPage);
    print("#3 _canLoadMore $_canLoadMore");
    if (_canLoadMore) {
      _offset += itemsPerPage;
      print("#4 new _offset $_offset");
    }
    setState(() {
      print("#5 getPokemonData setState");
      _pokemonList.addAll(list);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
              backgroundColor: Colors.redAccent,
              title: Text("Pokedex"),
              centerTitle: true,
              leading: Icon(null),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ))),
          SliverPadding(
            padding: EdgeInsets.all(6),
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (buildContext, index) =>
                        buildPokemonCard(index + 1, _pokemonList[index]),
                    childCount: _pokemonList.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    crossAxisCount: 2)),
          ),
          SliverToBoxAdapter(
              child: !_isLoading
                  ? Container(
                      height: 100,
                      padding: EdgeInsets.only(bottom: 16),
                      alignment: Alignment.center,
                      child: Image(
                        image: ImageUtils.pika_run,
                      ),
                    )
                  : SizedBox())
        ],
      ),
    );
  }
}

Widget buildPokemonCard(int index, PokemonInfo pokemonInfo) {
  print("buildPokemonCard");
  print("#1 index: $index");
  print("#2 name: ${pokemonInfo.name}");
  return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.only(top: 6),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          shadows: [
            BoxShadow(offset: Offset(3, 3), color: Colors.grey, blurRadius: 1)
          ]),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(right: 12),
              child: Text(
                "#$index",
                style: TextStyle(fontSize: 14, decoration: TextDecoration.none),
              ),
            ),
          ),
          Expanded(
              child: CachedNetworkImage(
            placeholder: (context, url) =>
                Image(image: ImageUtils.pokeball_logo),
            imageUrl: ApiService.getPokemonImageUrl(index),
          )),
          Padding(
            padding: EdgeInsets.all(6),
            child: Center(
              child: Text(
                pokemonInfo.name.capitalize(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
            ),
          )
        ],
      ));
}
