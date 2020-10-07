import 'dart:convert';

CharactersModel charactersModelFromJson(String str) =>
    CharactersModel.fromJson(json.decode(str));

String charactersModelToJson(CharactersModel data) =>
    json.encode(data.toJson());

class CharactersModel {
  CharactersModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  final int count;
  final String next;
  final String previous;
  final List<Result> results;

  factory CharactersModel.fromJson(Map<String, dynamic> json) =>
      CharactersModel(
        count: json["count"] == null ? 0 : json["count"],
        next: json["next"] == null ? "" : json["next"],
        previous: json["previous"] == null ? "" : json["previous"],
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? 0 : count,
        "next": next == null ? "" : next,
        "previous": previous == null ? "" : previous,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,
  });

  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String gender;
  final String homeworld;
  final List<String> films;
  final List<String> species;
  final List<String> vehicles;
  final List<String> starships;
  final DateTime created;
  final DateTime edited;
  final String url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"] == null ? "" : json["name"],
        height: json["height"] == null ? "" : json["height"],
        mass: json["mass"] == null ? "" : json["mass"],
        hairColor: json["hair_color"] == null ? "" : json["hair_color"],
        skinColor: json["skin_color"] == null ? "" : json["skin_color"],
        eyeColor: json["eye_color"] == null ? "" : json["eye_color"],
        birthYear: json["birth_year"] == null ? "" : json["birth_year"],
        gender: json["gender"] == null ? "" : json["gender"],
        homeworld: json["homeworld"] == null ? "" : json["homeworld"],
        films: json["films"] == null
            ? ""
            : List<String>.from(json["films"].map((x) => x)),
        species: json["species"] == null
            ? ""
            : List<String>.from(json["species"].map((x) => x)),
        vehicles: json["vehicles"] == null
            ? ""
            : List<String>.from(json["vehicles"].map((x) => x)),
        starships: json["starships"] == null
            ? ""
            : List<String>.from(json["starships"].map((x) => x)),
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        edited: json["edited"] == null ? null : DateTime.parse(json["edited"]),
        url: json["url"] == null ? "" : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? "" : name,
        "height": height == null ? "" : height,
        "mass": mass == null ? "" : mass,
        "hair_color": hairColor == null ? "" : hairColor,
        "skin_color": skinColor == null ? "" : skinColor,
        "eye_color": eyeColor == null ? "" : eyeColor,
        "birth_year": birthYear == null ? "" : birthYear,
        "gender": gender == null ? "" : gender,
        "homeworld": homeworld == null ? "" : homeworld,
        "films": films == null ? "" : List<String>.from(films.map((x) => x)),
        "species":
            species == null ? "" : List<String>.from(species.map((x) => x)),
        "vehicles":
            vehicles == null ? "" : List<String>.from(vehicles.map((x) => x)),
        "starships":
            starships == null ? "" : List<String>.from(starships.map((x) => x)),
        "created": created == null ? null : created.toIso8601String(),
        "edited": edited == null ? null : edited.toIso8601String(),
        "url": url == null ? "" : url,
      };
}
