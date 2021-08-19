import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/ui/homepage/widgets/ExpandedAppBar.dart';
import 'package:pokedex_project/utils/image_utils.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  double appBarHeight = 300;
  bool isShowTitle = false;

  @override
  void initState() {
    _scrollController.addListener(onScroll);
    super.initState();
  }

  void onScroll() {
    if (!_scrollController.hasClients) return;
    var offset = _scrollController.offset;
    var isShow = offset > appBarHeight - (kToolbarHeight + 50);
    if (isShowTitle != isShow) {
      setState(() {
        isShowTitle = isShow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.redAccent,
          // // bo 2 góc dưới của appbar collapsed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          // phần expanded appbar
          flexibleSpace: FlexibleSpaceBar(
            // cố định space bar ko bị body đè khi scroll up
            collapseMode: CollapseMode.pin,
            // phần content
            background: ExpandedAppBar(),
            centerTitle: true,
            title: Visibility(
              child: Text(
                "Pokedex",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    letterSpacing: 1),
              ),
              visible: isShowTitle,
            ),
          ),
          expandedHeight: appBarHeight,
          // floating: true => chỉ cần kéo lên là thấy appbar và appbar sẽ expand
          // false => kép lên trên cùng mới thấy appbar
          floating: false,
          // pinned = true => luôn thấy appbar
          pinned: true,
        ),
        _buildImages()
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

Widget _buildImages() => SliverGrid(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.teal[100 * (index % 10)],
            child: Image(
              image: ImageUtils.pokeball_logo,
            ),
          );
        },
        childCount: 10,
      ),
    );
