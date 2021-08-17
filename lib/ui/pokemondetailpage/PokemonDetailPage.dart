import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/domain/ApiService.dart';
import 'package:pokedex_project/extension/StringExtension.dart';
import 'package:pokedex_project/model/PokemonDetail.dart';
import 'package:pokedex_project/model/PokemonSpecies.dart';
import 'package:pokedex_project/ui/pokemondetailpage/widget/HeaderWidget.dart';
import 'package:pokedex_project/ui/pokemondetailpage/widget/TabAboutWidget.dart';
import 'package:pokedex_project/ui/pokemondetailpage/widget/TabBarHeaderWidget.dart';
import 'package:pokedex_project/ui/pokemondetailpage/widget/TabPokemonStatWidget.dart';
import 'package:pokedex_project/utils/color_utils.dart';

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
  bool _isPinned = false;

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
    print("#kToolbarHeight $kToolbarHeight");
    var visibleHeight = _extendAppBarHeight - (kToolbarHeight + 120);
    var isShow = offset > visibleHeight;
    // isShow = true -> ẩn title ở extendAppBar và hiện title ở collapseAppBar
    if (_isVisibleTitle != isShow) {
      setState(() {
        _isVisibleTitle = isShow;
      });
      // pin tabbar lại dưới appbar
      if (_isPinned != isShow) {
        setState(() {
          _isPinned = isShow;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
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
                TabBarInformationHeader(_isPinned, _backgroundColor)
              ];
            },
            body: Container(
              child: TabBarView(
                children: [
                  TabAboutPokemon(_pokemonSpcies, _pokemonDetail),
                  TabPokemonStats(_pokemonDetail),
                ],
              ),
            )),
      ),
    );
  }

  Future<void> onRefresh() async {
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
