import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/api/ApiServiceProvider.dart';
import 'package:star_wars/constants/constant.dart';
import 'package:star_wars/models/caractersModel.dart';
import 'package:star_wars/models/filmModel.dart';

class CharacterDetailsScreen extends StatefulWidget {
  static String id = "/characterDetails";
  final Results result;

  const CharacterDetailsScreen({Key key, this.result}) : super(key: key);

  @override
  _CharacterDetailsScreenState createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  ApiServiceProvider apiServiceProvider = new ApiServiceProvider();
  List<String> filmName = [];
  bool isLoading = false;
  bool isInternetAvailable = false;
  FilmModel filmModel;

  @override
  void initState() {
    super.initState();
    callApi(widget.result.films);
  }

  callApi(List<String> urls) async {
    isLoading = true;
    // Check internet status, and call the API to Fetch and cache the data
    isInternetAvailable = await Constant.isInternetAvailable();
    if (isInternetAvailable) {
      for (int i = 0; i < urls.length; i++) {
        filmModel = await apiServiceProvider.getFilmsData(urls[i]);
        filmName.add(filmModel.title);
      }
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.yellow, //change your color here
        ),
        backgroundColor: Color(0xFF1C1E22),
        centerTitle: true,
        title: Text(widget.result.name,
            style: TextStyle(color: Colors.yellow, fontFamily: "starWarsFont")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Image.asset(
              widget.result.gender == "female"
                  ? "assets/images/woman.png"
                  : "assets/images/man.png",
              height: height / 7,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.result.name,
                  style: TextStyle(fontSize: width / 21),
                ),
                Text(
                  widget.result.birthYear,
                  style: TextStyle(fontSize: width / 23),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Divider(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.result.height,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "height",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.result.mass,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Mass",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.result.gender,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Gender",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Divider(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, bottom: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.result.hairColor,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Hair color",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.result.skinColor,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Skin color",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.result.eyeColor,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Eye color",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 15),
              child: Divider(color: Colors.grey),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: height / 3,
                decoration: BoxDecoration(
                  color: Color(0xFF1C1E22),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 1), // changes po// sition of shadow
                    ),
                  ],
                ),
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : isInternetAvailable
                        ? Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "FILMS",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.yellow,
                                    fontFamily: "starWarsFont"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: (3 / 1),
                                  children: List.generate(
                                    filmName.length,
                                    (index) {
                                      return Container(
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.only(left: 4, right: 4),
                                        child: InputChip(
                                          label: Text(
                                            filmName[index],
                                            style: TextStyle(
                                                fontSize: width / 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Text(
                              'There was an error fetching the data.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
