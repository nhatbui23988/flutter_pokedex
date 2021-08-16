import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/domain/ApiService.dart';
import 'package:pokedex_project/extension/StringExtension.dart';
import 'package:pokedex_project/model/PokemonDetail.dart';
import 'package:pokedex_project/model/PokemonSpecies.dart';
import 'package:pokedex_project/ui/pokemondetailpage/widget/HeaderWidget.dart';
import 'package:pokedex_project/utils/color_utils.dart';
import 'package:pokedex_project/utils/image_utils.dart';

class PokemonDetailPage extends StatefulWidget {
  final int _pokemonId;

  const PokemonDetailPage(this._pokemonId);

  @override
  PokemonDetailState createState() => PokemonDetailState();
}

class PokemonDetailState extends State<PokemonDetailPage>
    with SingleTickerProviderStateMixin {
  bool _isVisibleTitle = false;
  double _extendAppBarHeight = 300;
  double _titleSize = 20;
  double _largeTitleSize = 30;
  double _flexSpaceMarginTop = 90;
  double _tabBarMaxSize = kToolbarHeight * 2;
  double _tabBarMinSize = kToolbarHeight / 2;
  double _tabBarHeight = 0;
  double _emptyMinSize = 0;
  double _emptyMaxSize = kToolbarHeight * 1.5;
  double _emptyContainerHeight = 0;

  String _pokemonName = "";

  //
  PokemonSpecies? _pokemonSpcies;
  PokemonDetail? _pokemonDetail;
  Color? _backgroundColor;

  //
  ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

  int get _pokemonId => widget._pokemonId;

  @override
  void initState() {
    _tabBarHeight = _tabBarMinSize;
    _emptyContainerHeight = _emptyMinSize;
    _scrollController.addListener(onScroll);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.repeat();
    super.initState();
    getPokemonDetail(_pokemonId);
    getPokemonSpecies(_pokemonId);
  }

  void getPokemonSpecies(int pokemonId) async {
    _pokemonSpcies = await ApiService.getPokemonSpicies(pokemonId);
    if (_pokemonSpcies != null) {
      setState(() {});
    }
  }

  void getPokemonDetail(int pokemonId) async {
    print("getPokemonDetail");
    _pokemonDetail = await ApiService.getPokemonDetail(pokemonId);
    print("#1 Pkm name: ${_pokemonDetail?.name}");
    print("#2 Type name: ${_pokemonDetail?.listType[0].name}");
    print("#3 Type size: ${_pokemonDetail?.listType.length}");
    setState(() {
      _pokemonName = _pokemonDetail?.name.capitalize() ?? "Unknow";
      _backgroundColor =
          AppColors.colorType(_pokemonDetail?.listType[0].name ?? "");
    });
  }

  void onScroll() {
    if (!_scrollController.hasClients) return;
    var offset = _scrollController.offset;
    print("onScroll");
    print("#offset $offset");
    print("#_extendAppBarHeight $_extendAppBarHeight");
    print("#TabBar ${kToolbarHeight * 1.5}");
    var visibleHeight = _extendAppBarHeight - (kToolbarHeight + 120);
    var isShow = offset > visibleHeight;
    if (_isVisibleTitle != isShow) {
      setState(() {
        _isVisibleTitle = isShow;
      });
    }
    if (offset > _extendAppBarHeight - kToolbarHeight * 0.5) {
      if (_tabBarHeight != _tabBarMaxSize) {
        setState(() {
          _tabBarHeight = _tabBarMaxSize;
          _emptyContainerHeight = _emptyMaxSize;
        });
      }
    } else {
      if (_tabBarHeight != _tabBarMinSize) {
        setState(() {
          _tabBarHeight = _tabBarMinSize;
          _emptyContainerHeight = _emptyMinSize;
        });
      }
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
          PokemonDetailHeaderWidget(
              this._pokemonId,
              this._animationController,
              this._backgroundColor,
              this._pokemonName,
              this._isVisibleTitle,
              this._titleSize,
              this._largeTitleSize,
              this._extendAppBarHeight,
              this._flexSpaceMarginTop,
              this._pokemonDetail?.listType ?? []),
          SliverFillRemaining(
            child: Container(
              color: _backgroundColor,
              child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(_tabBarHeight),
                      child: Container(
                        color: _backgroundColor,
                        child: Column(
                          children: [
                            Container(
                              height: _emptyContainerHeight,
                              color: _backgroundColor,
                            ),
                            Expanded(
                                child: Container(
                              child: TabBar(
                                tabs: [
                                  _buildTabTitle("About"),
                                  _buildTabTitle("Base Stat"),
                                  _buildTabTitle("Ability"),
                                ],
                              ),
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20))),
                                  color: Colors.white),
                            ))
                          ],
                        ),
                      ),
                    ),
                    body: Container(
                      child: TabBarView(
                        children: [
                          _buildTabAbout(),
                          Center(child: Text("Transit")),
                          Center(child: Text("Bike"))
                        ],
                      ),
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          color: Colors.white),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabTitle(String title) => Text(
        title,
        style: TextStyle(color: Colors.black),
      );

  Widget _buildTabAbout() => Container(margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12), child: Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          _pokemonSpcies?.listFlavorText[0].flavorText
              .replaceAll(RegExp("\n"), " ") ??
              "",
          style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal),
        ),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            color: Colors.grey[200]),
      ),
      Container()
    ],
  ),);

  Future<void> onRefresh() async {
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
