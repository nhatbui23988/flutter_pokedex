import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/model/Category.dart';
import 'package:pokedex_project/utils/color_utils.dart';
import 'package:pokedex_project/utils/image_utils.dart';
import 'package:pokedex_project/utils/route_util.dart';
import 'package:pokedex_project/ui/homepage/widgets/CategoriesWidget.dart';

class ExpandedAppBar extends StatefulWidget {
  @override
  ExpandedAppBarState createState() => ExpandedAppBarState();
}

class ExpandedAppBarState extends State<ExpandedAppBar> {
  @override
  Widget build(BuildContext context) {
    return _buildAppBarExpanded(context);
  }
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
                  onPressed: () => AppRoutes.pushRoute(context, Routes.pokedex),
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
      child:
          Opacity(opacity: 0.1, child: Image(image: ImageUtils.pokeball_logo)),
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

Widget categoryItem(BuildContext context, Category category) => Container(
      color: category.color,
      child: TextButton(
        onPressed: () => AppRoutes.pushRoute(context, category.route),
        child: Text(category.name),
      ),
    );
