import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/model/Category.dart';

class BuildCategories extends StatelessWidget {

  //
  final List<Category> categories;

  // constructor
  const BuildCategories({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(20),
      child: LayoutBuilder(builder: (_, constrains) {
        final spacing = 30;
        final width = constrains.maxWidth;
        final height = constrains.maxHeight;
        final itemWidth = (width - spacing) / 2;
        final itemHeight = (height - 2 * spacing) / 3;
        return Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.spaceBetween,
          children: categories.map((e) => _buildCategory(e, itemWidth, itemHeight)).toList(),
        );
      }),
    ));
  }
}

Widget _buildCategory(Category category, double width, double height) => Container(
      width: width,
      height: height,
      color: Colors.teal,
      child: Text(category.name),
    );
