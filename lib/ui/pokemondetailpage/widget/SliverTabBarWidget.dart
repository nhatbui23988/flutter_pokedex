import 'package:flutter/material.dart';

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget _child;
  final Color _backgroundColor;

  const SliverTabBarDelegate(this._child, this._backgroundColor);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: _backgroundColor, // ADD THE COLOR YOU WANT AS BACKGROUND.
        child: _child);
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
