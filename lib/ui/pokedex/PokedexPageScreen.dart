import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/domain/ApiService.dart';
import 'package:pokedex_project/extension/StringExtension.dart';
import 'package:pokedex_project/model/Pokemon.dart';
import 'package:pokedex_project/model/PokemonDetail.dart';
import 'package:pokedex_project/ui/pokemondetailpage/PokemonDetailPage.dart';
import 'package:pokedex_project/utils/color_utils.dart';
import 'package:pokedex_project/utils/image_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PokedexPage extends StatefulWidget {
  @override
  PokedexPageState createState() => PokedexPageState();
}

const int itemsPerPage = 50;

class PokedexPageState extends State<PokedexPage>
    with TickerProviderStateMixin {
  int _offset = 0;
  PokemonDetail? _pokemonSearch;
  List<PokemonInfo> _pokemonList = [];

  ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _canLoadMore = false;
  int _endReachedThreshold = 200;

  @override
  void initState() {
    _scrollController.addListener(onScroll);
    super.initState();
    getPokemonData();
  }

  void onScroll() {
    print("onScroll");
    print("#1 hasClients: ${_scrollController.hasClients}");
    print("#2 _isLoading: $_isLoading");
    print("#3 _canLoadMore $_canLoadMore");
    if (!_scrollController.hasClients || _isLoading || !_canLoadMore) return;
    final thresholdReached =
        _scrollController.position.extentAfter < _endReachedThreshold;
    print("#4 position.extentAfter: ${_scrollController.position.extentAfter}");
    print("#5 thresholdReached $thresholdReached");
    if (thresholdReached) {
      _isLoading = true;
      getPokemonData();
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      _offset = 0;
      _pokemonList = [];
      _canLoadMore = true;
      _isLoading = true;
      getPokemonData();
    });
  }

  void getPokemonData() async {
    print("getPokemonData");
    print("#1 fetchPokedex offset: $_offset, itemPerpage: $itemsPerPage");
    List<PokemonInfo> list =
        await ApiService.fetchPokedex(_offset, itemsPerPage);
    print("#2 list.length ${list.length}");
    _canLoadMore = !(list.length < itemsPerPage);
    print("#3 _canLoadMore $_canLoadMore");
    if (_canLoadMore) {
      _offset += itemsPerPage;
      print("#4 new _offset $_offset");
    }
    setState(() {
      print("#5 getPokemonData setState");
      _pokemonList.addAll(list);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
          SliverAppBar(
              backgroundColor: Colors.redAccent,
              title: Text("Pokedex"),
              centerTitle: true,
              leading: Icon(null),
              expandedHeight: 120,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  alignment: Alignment.bottomCenter,
                  child: _buildSearchView(),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ))),
          SliverPadding(
            padding: EdgeInsets.all(6),
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (buildContext, index) => buildPokemonCard(
                        buildContext, index + 1, _pokemonList[index]),
                    childCount: _pokemonList.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    crossAxisCount: 2)),
          ),
          SliverToBoxAdapter(
              child: !_isLoading
                  ? Container(
                      height: 100,
                      padding: EdgeInsets.only(bottom: 16),
                      alignment: Alignment.center,
                      child: Image(
                        image: ImageUtils.pika_run,
                      ),
                    )
                  : SizedBox())
        ],
      ),
    );
  }

  Widget _buildSearchView() => Container(
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
    onStartSearch(keyword.toLowerCase().trim());
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

  Widget buildPokemonCard(
      BuildContext context, int index, PokemonInfo pokemonInfo) {
    return Container(
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.only(top: 6),
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            shadows: [
              BoxShadow(offset: Offset(3, 3), color: Colors.grey, blurRadius: 1)
            ]),
        child: TextButton(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  child: Text(
                    "#$index",
                    style: TextStyle(
                        fontSize: 14, decoration: TextDecoration.none),
                  ),
                ),
              ),
              Expanded(
                  child: CachedNetworkImage(
                placeholder: (context, url) =>
                    Image(image: ImageUtils.pokeball_logo),
                imageUrl: ApiService.getPokemonImageUrl(index),
              )),
              Padding(
                padding: EdgeInsets.all(6),
                child: Center(
                  child: Text(
                    pokemonInfo.name.capitalize(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Colors.black),
                  ),
                ),
              )
            ],
          ),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) => PokemonDetailPage(index, null))),
        ));
  }
}
