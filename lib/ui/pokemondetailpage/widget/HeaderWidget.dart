import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/domain/ApiService.dart';
import 'package:pokedex_project/extension/StringExtension.dart';
import 'package:pokedex_project/model/PokemonType.dart';
import 'package:pokedex_project/utils/color_utils.dart';
import 'package:pokedex_project/utils/image_utils.dart';

class PokemonDetailHeaderWidget extends StatelessWidget {
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
      this._listType);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: 0,
      floating: true,
      pinned: true,
      centerTitle: true,
      backgroundColor: _backgroundColor,
      expandedHeight: _extendAppBarHeight,
      actions: [
        IconButton(onPressed: () => {}, icon: Icon(Icons.favorite_border))
      ],
      title: Visibility(
        child: Text(
          _pokemonName,
          style: TextStyle(fontSize: _titleSize, fontWeight: FontWeight.bold),
        ),
        visible: _isVisibleTitle,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Container(
              color: _backgroundColor ?? Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // work as margin top
                  SizedBox(
                    height: _flexSpaceMarginTop,
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
                                    _pokemonName,
                                    style: TextStyle(
                                        fontSize: _largeTitleSize,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                visible: !_isVisibleTitle,
                              )),
                          Container(
                            // pokemon index
                            width: constraints.maxWidth / 2 - 24,
                            alignment: Alignment.centerRight,
                            child: Text(
                              _pokemonId.toString().toPokemonIndex(),
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
                        itemCount: _listType.length,
                        itemBuilder: (buildContext, index) =>
                            _buildPkmTypeName(_listType[index].name)),
                  ),
                  // display pokemon image
                  Expanded(
                    child: LayoutBuilder(builder: (buildContext, constraints) {
                      return Container(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          children: [
                            // pokeball quay hình tròn
                            AnimatedBuilder(
                              animation: _animationController.view,
                              builder: (buildContext, child) {
                                return Transform.rotate(
                                    angle: _animationController.value * 2 * pi,
                                    child: Image(
                                      height: constraints.maxHeight,
                                      image: ImageUtils.pokeball_black,
                                      color: Colors.white70,
                                    ));
                              },
                            ),
                            CachedNetworkImage(
                              height: constraints.maxHeight - 20,
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
            // ========> background decoration
            Positioned(
              child: Opacity(child: Image(
                image: ImageUtils.pkb_3,
                width: 180,
                height: 180,
                color: _bgDecorColor,
              ), opacity: _bgDecorOpacity,),
              top: -20,
              right: 0,
            ),
            Positioned(
              child: RotationTransition(
                child: Opacity(child: Image(
                  image: ImageUtils.pkm_step,
                  width: 80,
                  height: 80,
                  color: _bgDecorColor,
                ), opacity: _bgDecorOpacity,),
                turns: AlwaysStoppedAnimation(-40 / 360),
              ),
              right: -5,
              top: 230,
            ),
            Positioned(
              left: -50,
              top: 200,
              child: RotationTransition(
                child: Opacity(child: Container(
                  height: 100,
                  width: 100,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      color: _bgDecorColor),
                ), opacity: _bgDecorOpacity,),
                turns: AlwaysStoppedAnimation(-40 / 360),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
