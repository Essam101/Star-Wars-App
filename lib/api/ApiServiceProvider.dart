import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:star_wars/models/caractersModel.dart';
import 'package:star_wars/models/filmModel.dart';

class ApiServiceProvider {
  FilmModel filmsModel;

   Future<CharacterModel> getCharacters({pageNumber = 1}) async {
    CharacterModel characterModel;
    var response = await get("https://swapi.dev/api/people/?page=$pageNumber");
    if (response.statusCode == 200) {
      characterModel = CharacterModel.fromJson(json.decode(response.body));
    }
    return characterModel;
  }

   Future<FilmModel> getFilmsData(url) async {
    FilmModel filmModel;
    String handelUrl = url.replaceAll("/", "");
    handelUrl = handelUrl.replaceAll(":", "");
    handelUrl = handelUrl.replaceAll(".", "");

    String fileName = "$handelUrl.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      filmModel = FilmModel.fromJson(json.decode(jsonData));
    } else {
      print("Loading from API");
      var response = await get(url);
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        filmModel = FilmModel.fromJson(json.decode(jsonResponse));
        //save json in local file
        file.writeAsStringSync(jsonResponse, flush: true, mode: FileMode.write);
      }
    }
    return filmModel;
  }

  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

}
