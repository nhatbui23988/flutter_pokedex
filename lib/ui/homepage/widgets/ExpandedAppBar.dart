import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokedex_project/domain/ApiService.dart';
import 'package:pokedex_project/model/Category.dart';
import 'package:pokedex_project/model/PokemonDetail.dart';
import 'package:pokedex_project/ui/pokemondetailpage/PokemonDetailPage.dart';
import 'package:pokedex_project/utils/color_utils.dart';
import 'package:pokedex_project/utils/image_utils.dart';
import 'package:pokedex_project/utils/route_util.dart';

class ExpandedAppBar extends StatefulWidget {
  @override
  ExpandedAppBarState createState() => ExpandedAppBarState();
}

class ExpandedAppBarState extends State<ExpandedAppBar> {
  PokemonDetail? _pokemonSearch;

  @override
  Widget build(BuildContext context) {
    return _buildAppBarExpanded(context);
  }

  Widget _buildAppBarExpanded(BuildContext context) => Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            _buildBackgroundCard(),
            // body content
            Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Text(
                  "Find your Pokemon",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(child: _buildSearchView(context)),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextButton(
                    onPressed: () =>
                        AppRoutes.pushRoute(context, Routes.pokedex),
                    child: Text(
                      "Pokedex",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.blueGrey),
                )
                // BuildCategories(categories: categories,)
              ],
            )
          ],
        ),
      );

  /// hình background nằm ẩn phía sau
  Widget _buildBackgroundCard() => Center(
          child: Container(
        padding: EdgeInsets.all(16),
        child: Opacity(
            opacity: 0.05, child: Image(image: ImageUtils.pokeball_logo)),
      ));

  Widget _buildSearchView(BuildContext context) => Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: ShapeDecoration(
        shape: StadiumBorder(
            side: BorderSide(
                width: 0.1, color: Colors.black, style: BorderStyle.solid)),
        color: AppColors.grey,
      ),
      child: Row(
        children: [
          SizedBox(width: 6),
          Icon(Icons.search_outlined),
          SizedBox(width: 6),
          Expanded(
            // input field search here
            child: TextField(
              onSubmitted: onSearch,
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                  isDense: true,
                  hintText: "Search",
                  // bỏ padding default của edit text
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none),
            ),
          ),
        ],
      ));

  void onSearch(String keyword) {
    print("onSearch");
    print("#1 keyword: $keyword");
    onStartSearch(keyword);
  }

  void onStartSearch(String keyword) async {
    _pokemonSearch = await ApiService.getPokemonDetailByName(keyword);
    if (_pokemonSearch == null) {
      print("#2 _pokemonSearch == null");
      Fluttertoast.showToast(
          msg: "Không tìm thấy pokemon này",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print("#2 _pokemonSearch ${_pokemonSearch?.name}");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (builder) =>
              PokemonDetailPage(_pokemonSearch?.id ?? 0, _pokemonSearch)));
    }
  }

  Widget categoryItem(BuildContext context, Category category) => Container(
        color: category.color,
        child: TextButton(
          onPressed: null,
          child: Text(category.name),
        ),
      );
}
