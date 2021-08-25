import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/domain/ApiService.dart';
import 'package:pokedex_project/model/PokemonDetail.dart';
import 'package:pokedex_project/model/PokemonSpecies.dart';
import 'package:pokedex_project/utils/color_utils.dart';
import 'package:pokedex_project/extension/StringExtension.dart';
import 'package:pokedex_project/utils/image_utils.dart';
import 'HeaderWidget.dart';
import 'TabAboutWidget.dart';
import 'TabBarHeaderWidget.dart';

class PokemonDetailBodyWidget extends StatefulWidget {
  final int _pokemonId;
  final bool _isVisible;

  const PokemonDetailBodyWidget(this._pokemonId, this._isVisible);

  @override
  PokemonDetailBodyState createState() => PokemonDetailBodyState();
}

class PokemonDetailBodyState extends State<PokemonDetailBodyWidget>
    with SingleTickerProviderStateMixin {
  //
  bool _isVisibleTitle = false;
  double _extendAppBarHeight = 300;
  double _titleSize = 20;
  double _largeTitleSize = 30;
  double _flexSpaceMarginTop = 90;
  bool _isPinned = false;
  int _countCompletedAPI = 0;

  //
  PokemonSpecies? _pokemonSpecies;
  PokemonDetail? _pokemonDetail;
  Color? _backgroundColor = AppColors.black_20;
  String _pokemonName = "??????";

  //
  ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

  //
  bool get _isAllowVisible => widget._isVisible;

  int get _pokemonId => widget._pokemonId;
  bool isVisibleWaitingImage = true;

  @override
  void initState() {
    if (_isAllowVisible) {
      getPokemonDetail(_pokemonId);
      getPokemonSpecies(_pokemonId);
    }
    print("=========== initState ============");
    print("#1 pokemonId: $_pokemonId");
    _scrollController.addListener(onScroll);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 6));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAllowVisible) {
      return _buildBodyContent();
    }
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  // api
  void getPokemonSpecies(int pokemonId) async {
    _pokemonSpecies = await ApiService.getPokemonSpicies(pokemonId);
    _countCompletedAPI = _countCompletedAPI + 1;
    if (_countCompletedAPI == 2) {
      setState(() {});
    }
  }

  void getPokemonDetail(int pokemonId) async {
    print("=================");
    print("getPokemonDetail");
    print("#1 pokemonId: $pokemonId");
    _pokemonDetail = await ApiService.getPokemonDetailByID(pokemonId);
    _pokemonName = _pokemonDetail?.name.capitalize() ?? "?????";
    _backgroundColor =
        AppColors.colorType(_pokemonDetail?.listType[0].name ?? "");
    _countCompletedAPI = _countCompletedAPI + 1;
    if (_countCompletedAPI == 2) {
      setState(() {});
    }
  }

  void onScroll() {
    if (!_scrollController.hasClients) return;
    var offset = _scrollController.offset;
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

  Widget _buildBodyContent() =>
      LayoutBuilder(builder: (buildContext, constraints) {
        return Stack(
          children: [
            NestedScrollView(
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
                  // if bg == AppColors.black_20 -> chưa lấy được data từ api -> set bg = white
                  TabBarInformationHeader(_isPinned, _backgroundColor == AppColors.black_20 ? Colors.white : _backgroundColor)
                ];
              },
              body: TabAboutPokemon(_pokemonSpecies, _pokemonDetail),
            ),
            Visibility(
              visible: isVisibleWaitingImage,
              child: AnimatedOpacity(
                onEnd: () => setState(() {
                  isVisibleWaitingImage = false;
                }),
                opacity:
                    _pokemonDetail == null || _pokemonSpecies == null ? 1.0 : 0,
                duration: Duration(milliseconds: 300),
                child: Container(
                  alignment: Alignment.center,
                  color: AppColors.black_20,
                  child: CircularProgressIndicator(),
                ),
              ),
            )
            // _buildLoading(constraints)
          ],
        );
      });

  @override
  void dispose() {
    print("===> dispose <===");
    print("_pokemonId : $_pokemonId ");
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
