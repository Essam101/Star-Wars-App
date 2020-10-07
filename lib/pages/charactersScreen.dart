import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pagination_wrapper/flutter_pagination_wrapper.dart';
import 'package:http/http.dart';
import 'package:star_wars/models/caractersModel.dart';
import 'package:star_wars/pages/characterDetailsScreen.dart';

class CharactersScreen extends StatefulWidget {
  static String id = "/Characters";

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  CharactersModel charactersModel;
  final _key = GlobalKey<PaginatorState<PagesData, dynamic>>();

  @override
  void initState() {
    super.initState();
  }

  //get Characters data
  getCharacters({pageNumber = 1}) async {
    var response = await get("https://swapi.dev/api/people/?page=$pageNumber");
    charactersModel = charactersModelFromJson(utf8.decode(response.bodyBytes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1E22),
        centerTitle: true,
        title: Text('Characters'),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Paginator<PagesData, Result>(
          key: _key,
          pageLoadFuture: _pageLoadFuture,
          pageErrorChecker: _pageErrorChecker,
          totalItemsGetter: _totalItemsGetter,
          pageItemsGetter: _pageItemsGetter,
          itemListTileBuilder: _itemListTileBuilder,
          loadingListTileBuilder: _loadingListTileBuilder,
          errorListTileBuilder: _errorListTileBuilder,
          emptyListWidgetBuilder: _emptyListWidgetBuilder,
          listBuilder: (context, itemBuilder, itemCount) {
            return ListView.builder(
              itemBuilder: itemBuilder,
              itemCount: itemCount,
            );
          },
        ),
      ),
    );
  }

  Future<PagesData> _pageLoadFuture(int pageNumber) async {
    try {
      await getCharacters(pageNumber: pageNumber);
      return PagesData(
          totalCount: 82,
          characterObj: charactersModel.results.toList(growable: false));
    } on SocketException {
      // If there's a network problem
      print("Error Network");
      return PagesData(totalCount: 0, characterObj: null);
    }
  }

  // Checks for page errors
  bool _pageErrorChecker(PagesData page) => page.characterObj == null;

  // Return the total count of items
  int _totalItemsGetter(PagesData page) => page.totalCount;

  // Return the list of food items
  List<Result> _pageItemsGetter(PagesData page) => page.characterObj;

  // Build a list tile for an item
  Widget _itemListTileBuilder(BuildContext context, Result result, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CharacterDetailsScreen(
                result: result,
              ),
            ));
      },
      child: Card(
        child: ListTile(
          leading: Image.asset(result.gender == "female"
              ? "images/woman.png"
              : "images/man.png"),
          title: Text(result.name),
          subtitle: Text(''),
          isThreeLine: false,
        ),
      ),
    );
  }

  // Build a loading tile
  Widget _loadingListTileBuilder(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: const Padding(
        padding: const EdgeInsets.all(16),
        child: const SizedBox(
          width: 24,
          height: 24,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }

  // Build an error tile, to be shown at the end of the list when there's a network error.
  Widget _errorListTileBuilder(
      BuildContext context, PagesData page, int index) {
    return Column(
      children: [
        SizedBox(
          height: 200,
        ),
        Align(
          alignment: Alignment.center,
          child: Text('There was an error fetching the data.'),
        ),
      ],
    );
  }

  // Build a widget to show when there are no items
  Widget _emptyListWidgetBuilder(BuildContext context, PagesData page) {
    return const Center(
      child: const Text('No items.'),
    );
  }

  Future<void> _onRefresh() async {
    // Call the [Paginator] state's refresh method
    _key.currentState.refresh();
  }
}

class PagesData {
  final totalCount;
  final List<Result> characterObj;

  PagesData({this.totalCount, this.characterObj});
}
