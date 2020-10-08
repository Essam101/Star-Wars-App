import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:star_wars/models/caractersModel.dart';
import 'package:star_wars/models/filmModel.dart';

class ApiServiceProvider {
  FilmModel filmsModel;
  CharacterModel characterModel;

  //Fetching characters data
  // page Number is optional and It is sent from the pagination function
  Future<CharacterModel> getCharacters({pageNumber = 1}) async {
    var response = await get("https://swapi.dev/api/people/?page=$pageNumber");
    if (response.statusCode == 200) {
      characterModel = CharacterModel.fromJson(json.decode(response.body));
    }
    return characterModel;
  }

  // Fetching films data with caching
  Future<FilmModel> getFilmsData(url) async {
    // Make the name of the cache file the same as the URL
    String handelUrl = url.replaceAll("/", "");
    handelUrl = handelUrl.replaceAll(":", "");
    handelUrl = handelUrl.replaceAll(".", "");
    String fileName = "$handelUrl.json";

    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    // Check if there is cached data
    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      filmsModel = FilmModel.fromJson(json.decode(jsonData));
    } else {
      print("Loading from API");
      var response = await get(url);
      // calling API and caching this the data
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        filmsModel = FilmModel.fromJson(json.decode(jsonResponse));
        //save json in local file
        file.writeAsStringSync(jsonResponse, flush: true, mode: FileMode.write);
      }
    }
    return filmsModel;
  }

  // Clear cache space
  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }
}
