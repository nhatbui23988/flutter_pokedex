import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/domain/ApiService.dart';
import 'package:pokedex_project/extension/StringExtension.dart';
import 'package:pokedex_project/model/PokemonType.dart';
import 'package:pokedex_project/utils/color_utils.dart';
import 'package:pokedex_project/utils/image_utils.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

const int MAX_POKEMON = 1000;

class PokemonDetailHeaderWidget extends StatefulWidget {
  final Color? _backgroundColor;
  final double _extendAppBarHeight;
  final String _pokemonName;
  final double _titleSize;
  final double _largeTitleSize;
  final bool _isVisibleTitle;
  final double _flexSpaceMarginTop;
  final int _pokemonId;
  final List<PokemonType> _listType;
  final AnimationController _animationController;
  final _bgDecorOpacity = 0.15;
  final _bgDecorColor = Colors.white;
  final void Function(int) onChangedPokemonId;

  const PokemonDetailHeaderWidget(
      this._pokemonId,
      this._animationController,
      this._backgroundColor,
      this._pokemonName,
      this._isVisibleTitle,
      this._titleSize,
      this._largeTitleSize,
      this._extendAppBarHeight,
      this._flexSpaceMarginTop,
      this._listType,
      this.onChangedPokemonId);

  @override
  PokemonDetailHeaderState createState() => PokemonDetailHeaderState();
}

class PokemonDetailHeaderState extends State<PokemonDetailHeaderWidget> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = widget._pokemonId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: 0,
      floating: true,
      pinned: true,
      centerTitle: true,
      backgroundColor: widget._backgroundColor,
      expandedHeight: widget._extendAppBarHeight,
      actions: [
        IconButton(onPressed: () => {}, icon: Icon(Icons.favorite_border))
      ],
      title: Visibility(
        child: Text(
          widget._pokemonName,
          style: TextStyle(
              fontSize: widget._titleSize, fontWeight: FontWeight.bold),
        ),
        visible: widget._isVisibleTitle,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Container(
              color: widget._backgroundColor ?? Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // work as margin top
                  SizedBox(
                    height: widget._flexSpaceMarginTop,
                  ),
                  // display pokemon name
                  LayoutBuilder(builder: (buildContext, constraints) {
                    return Container(
                      child: Row(
                        children: [
                          Container(
                              // trừ di padding cua text
                              width: constraints.maxWidth / 2,
                              padding: EdgeInsets.only(left: 24),
                              child: Visibility(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget._pokemonName,
                                    style: TextStyle(
                                        fontSize: widget._largeTitleSize,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                visible: !widget._isVisibleTitle,
                              )),
                          Container(
                            // pokemon index
                            width: constraints.maxWidth / 2 - 24,
                            alignment: Alignment.centerRight,
                            child: Text(
                              widget._pokemonId.toString().toPokemonIndex(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  // list pokemon type
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 6),
                    alignment: Alignment.centerLeft,
                    height: 20,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget._listType.length,
                        itemBuilder: (buildContext, index) =>
                            _buildPkmTypeName(widget._listType[index].name)),
                  ),
                  // display pokemon image
                  _buildListPokemonScrollable()
                ],
              ),
            ),
            // ========> background decoration
            Positioned(
              child: Opacity(
                child: Image(
                  image: ImageUtils.pkb_3,
                  width: 180,
                  height: 180,
                  color: widget._bgDecorColor,
                ),
                opacity: widget._bgDecorOpacity,
              ),
              top: -20,
              right: 0,
            ),
            Positioned(
              child: RotationTransition(
                child: Opacity(
                  child: Image(
                    image: ImageUtils.pkm_step,
                    width: 80,
                    height: 80,
                    color: widget._bgDecorColor,
                  ),
                  opacity: widget._bgDecorOpacity,
                ),
                turns: AlwaysStoppedAnimation(-40 / 360),
              ),
              right: -5,
              top: 230,
            ),
            Positioned(
              left: -50,
              top: 200,
              child: RotationTransition(
                child: Opacity(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        color: widget._bgDecorColor),
                  ),
                  opacity: widget._bgDecorOpacity,
                ),
                turns: AlwaysStoppedAnimation(-40 / 360),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListPokemonScrollable() => Expanded(
        child: LayoutBuilder(builder: (buildContext, constraints) {
          return Container(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                // pokeball quay hình tròn
                AnimatedBuilder(
                  animation: widget._animationController.view,
                  builder: (buildContext, child) {
                    return Transform.rotate(
                        angle: widget._animationController.value * 2 * pi,
                        child: Image(
                          height: constraints.maxHeight,
                          image: ImageUtils.pokeball_black,
                          color: Colors.white70,
                        ));
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: ScrollSnapList(
                    onItemFocus: onItemFocusChange,
                    dynamicItemSize: true,
                    itemSize: constraints.maxHeight,
                    itemCount: MAX_POKEMON,
                    // id = index + 1
                    initialIndex: widget._pokemonId.toDouble() - 1,
                    itemBuilder: (buildContext, index) => _buildPokemonImage(
                        true, constraints.maxHeight, index + 1),
                  ),
                ),
              ],
              alignment: Alignment.bottomCenter,
            ),
          );
        }),
      );

  Widget _buildPokemonImage(
      bool isVisible, double constraintsHeight, int pokemonId) {
    bool isShowImage = false;
    if (pokemonId == currentIndex ||
        pokemonId == currentIndex - 1 ||
        pokemonId == currentIndex + 1) {
      isShowImage = true;
    }
    return isShowImage
        ? CachedNetworkImage(
            height: constraintsHeight,
            imageUrl: ApiService.getPokemonImageUrl(pokemonId),
          )
        : Image(image: ImageUtils.egg_color);
  }

  Widget _buildPkmTypeName(String typeName) => Container(
        constraints: BoxConstraints(minWidth: 70),
        padding: EdgeInsets.symmetric(horizontal: 4),
        margin: EdgeInsets.only(right: 6),
        alignment: Alignment.center,
        decoration:
            ShapeDecoration(shape: StadiumBorder(), color: Colors.white70),
        child: Text(
          typeName.capitalize(),
          style: TextStyle(
            fontSize: 14,
            color: AppColors.colorType(typeName),
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  void onItemFocusChange(int index) {
    setState(() {
      currentIndex = index + 1;
      widget.onChangedPokemonId(currentIndex);
    });
  }
}
