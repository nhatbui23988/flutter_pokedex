import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SliverTabBarWidget.dart';

class TabBarInformationHeader extends StatelessWidget {
  final bool _isPinned;
  final Color? _backgroundColor;

  const TabBarInformationHeader(this._isPinned, this._backgroundColor);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: _isPinned,
      delegate: SliverTabBarDelegate(
          Container(
            height: kToolbarHeight,
            alignment: Alignment.center,
            child: Text("About Pokemon", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24))),
                color: Colors.white),
          ),
          _backgroundColor ?? Colors.white),
    );
  }
}
