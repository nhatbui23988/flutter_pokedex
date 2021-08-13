import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  double _flexSpaceMarginTop = 70;
  double _pokeBallSize = 150;
  late AnimationController _animationController;

  int get _pokemonId => widget._pokemonId;

  @override
  void initState() {
    _scrollController.addListener(onScroll);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.repeat();
    super.initState();
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
          SliverAppBar(
            toolbarHeight: 70,
            titleSpacing: 0,
            floating: true,
            pinned: true,
            backgroundColor: Colors.redAccent,
            expandedHeight: _extendAppBarHeight,
            title: Padding(
              padding: EdgeInsets.only(left: 24),
              child: Visibility(
                child: Text(
                  "Pokemon Name",
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
                    SizedBox(
                      height: _flexSpaceMarginTop,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Visibility(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Pokemon Name",
                              style: TextStyle(
                                  fontSize: _titleSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          visible: !_isVisibleTitle,
                        )),
                    Container(
                      height: _extendAppBarHeight -
                          _flexSpaceMarginTop -
                          _titleSize,
                      child: LayoutBuilder(builder: (buildContext, constraints) {
                        print("#maxHeight ${constraints.maxHeight}");
                        print("#minHeight ${constraints.minHeight}");
                        print("#maxWidth ${constraints.maxWidth}");
                        print("#minWidth ${constraints.minWidth}");
                        print("#hasBoundedHeight ${constraints.hasBoundedHeight}");
                        print("#hasBoundedWidth ${constraints.hasBoundedWidth}");
                        print("#hasTightHeight ${constraints.hasTightHeight}");
                        print("#hasTightWidth ${constraints.hasTightWidth}");
                        print("#biggest ${constraints.biggest}");
                        return Container(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              AnimatedBuilder(
                                animation: _animationController.view,
                                builder: (buildContext, child) {
                                  return Transform.rotate(
                                      angle: _animationController.value *
                                          2 *
                                          pi,
                                      child: Image(
                                        image: ImageUtils.pokeball_black,
                                        color: Colors.white70,
                                      ));
                                },
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
