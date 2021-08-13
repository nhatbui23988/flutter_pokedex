import 'package:flutter/material.dart';
import 'package:pokedex_project/utils/route_util.dart';

class Category {
  const Category(this.color, this.name, this.route, this.image);

  final Color color;
  final String name;
  final Routes route;
  final Image? image;
}

const List<Category> categories = [
  Category(Colors.green, "Pokedex", Routes.pokedex, null),
  Category(Colors.green, "Pokedex", Routes.pokedex, null),
  Category(Colors.green, "Pokedex", Routes.pokedex, null),
];
