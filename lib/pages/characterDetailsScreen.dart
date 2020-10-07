import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:star_wars/constants/constant.dart';
import 'package:star_wars/models/caractersModel.dart';
import 'package:star_wars/models/filmModel.dart';

class CharacterDetailsScreen extends StatefulWidget {
  static String id = "/characterDetails";
  final Result result;

  const CharacterDetailsScreen({Key key, this.result}) : super(key: key);

  @override
  _CharacterDetailsScreenState createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  FilmModel filmModel;
  List<String> filmName = [];
  bool isLoading = false;
  bool isInternetAvailable = false;

  @override
  void initState() {
    super.initState();
    callApi(widget.result.films);
  }

  callApi(List<String> urls) async {
    isLoading = true;
    //Check internet status
    isInternetAvailable = await Constant.isInternetAvailable();
    if (isInternetAvailable) {
      for (int i = 0; i < urls.length; i++) {
        await getFilmsData(urls[i]);
        filmName.add(filmModel.title);
      }
    }
    isLoading = false;
    setState(() {});
  }

  //Get films data
  getFilmsData(url) async {
    var response = await get(url);
    filmModel = filmModelFromJson(utf8.decode(response.bodyBytes));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1C1E22),
          centerTitle: true,
          title: Text(widget.result.name),
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
                    ? "images/woman.png"
                    : "images/man.png",
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
                  width: width / 1.1,
                  height: height / 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                                  "Films",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
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
                                          alignment: Alignment.topCenter,
                                          padding: EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: InputChip(
                                            label: Text(
                                              filmName[index],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
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
                              child:
                                  Text('There was an error fetching the data.'),
                            ),
                ),
              )
            ],
          ),
        ));
  }
}
