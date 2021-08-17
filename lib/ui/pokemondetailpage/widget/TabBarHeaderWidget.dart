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
            child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 2.5,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.symmetric(vertical: 6),
                tabs: [
                  Tab(text: "About"),
                  Tab(text: "Base Stat"),
                ]),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(36))),
                color: Colors.white),
          ),
          _backgroundColor ?? Colors.white),
    );
  }
}
