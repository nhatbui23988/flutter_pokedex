import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/domain/ApiService.dart';
import 'package:pokedex_project/extension/StringExtension.dart';
import 'package:pokedex_project/model/PokemonSpecies.dart';
import 'package:pokedex_project/utils/image_utils.dart';

class PokemonDetailPage extends StatefulWidget {
  final int _pokemonId;

  const PokemonDetailPage(this._pokemonId);

  @override
  PokemonDetailState createState() => PokemonDetailState();
}

class PokemonDetailState extends State<PokemonDetailPage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  bool _isVisibleTitle = false;
  double _extendAppBarHeight = 300;
  double _titleSize = 20;
  double _flexSpaceMarginTop = 90;
  String _pokemonName = "";
  late AnimationController _animationController;
  PokemonSpecies? _pokemonSpcies;

  int get _pokemonId => widget._pokemonId;

  @override
  void initState() {
    print("Pokemon Detail initState");
    _scrollController.addListener(onScroll);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.repeat();
    super.initState();
    getPokemonSpecies(_pokemonId);
  }

  void getPokemonSpecies(int pokemonId) async {
    _pokemonSpcies = await ApiService.getPokemonSpicies(pokemonId);
    if (_pokemonSpcies != null) {
      setState(() {
        _pokemonName = _pokemonSpcies?.name.capitalize() ?? "Unknow";
      });
    }
  }

  void onScroll() {
    if (!_scrollController.hasClients) return;
    var offset = _scrollController.offset;
    var visibleHeight = _extendAppBarHeight - (kToolbarHeight + 120);
    var isShow = offset > visibleHeight;
    if (_isVisibleTitle != isShow) {
      setState(() {
        _isVisibleTitle = isShow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
          SliverAppBar(
            titleSpacing: 0,
            floating: true,
            pinned: true,
            centerTitle: true,
            backgroundColor: Colors.redAccent,
            expandedHeight: _extendAppBarHeight,
            title: Padding(
              padding: EdgeInsets.only(left: 24),
              child: Visibility(
                child: Text(
                  _pokemonName,
                  style: TextStyle(
                      fontSize: _titleSize, fontWeight: FontWeight.bold),
                ),
                visible: _isVisibleTitle,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.redAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // work như margin top
                    SizedBox(
                      height: _flexSpaceMarginTop,
                    ),
                    // display pokemon name
                    Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Visibility(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              _pokemonName,
                              style: TextStyle(
                                  fontSize: _titleSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          visible: !_isVisibleTitle,
                        )),
                    // ListView(
                    //   scrollDirection: Axis.horizontal,
                    //   children: _pokemonSpcies?.pkmGroupName
                    //           .map((e) => _buildPkmGroupName(e))
                    //           .toList() ??
                    //       [],
                    // ),
                    // display pokemon image
                    Expanded(
                      child:
                          LayoutBuilder(builder: (buildContext, constraints) {
                        return Container(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              AnimatedBuilder(
                                animation: _animationController.view,
                                builder: (buildContext, child) {
                                  return Transform.rotate(
                                      angle:
                                          _animationController.value * 2 * pi,
                                      child: Image(
                                        height: constraints.maxHeight-10,
                                        image: ImageUtils.pokeball_black,
                                        color: Colors.white70,
                                      ));
                                },
                              ),
                              CachedNetworkImage(
                                height: constraints.maxHeight-20,
                                imageUrl:
                                    ApiService.getPokemonImageUrl(_pokemonId),
                              )
                            ],
                            alignment: Alignment.bottomCenter,
                            fit: StackFit.passthrough,
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              height: 500,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPkmGroupName(String e) => Container(child: Text(e),);

  Future<void> onRefresh() async {
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
