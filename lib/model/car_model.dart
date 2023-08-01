// To parse this JSON data, do
//
//     final car = carFromMap(jsonString);

import 'dart:convert';

Car carFromMap(String str) => Car.fromMap(json.decode(str));

String carToMap(Car data) => json.encode(data.toMap());

class Car {
  final String carName;
  final String country;
  final int since;
  final List<Model> model;

  Car({
    required this.carName,
    required this.country,
    required this.since,
    required this.model,
  });

  factory Car.fromMap(Map<String, dynamic> json) => Car(
        carName: json["car_name"],
        country: json["Country"],
        since: json["Since"],
        model: List<Model>.from(json["model"].map((x) => Model.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "car_name": carName,
        "Country": country,
        "Since": since,
        "model": List<dynamic>.from(model.map((x) => x.toMap())),
      };
}

class Model {
  final String modelName;
  final int price;
  final bool diesel;

  Model({
    required this.modelName,
    required this.price,
    required this.diesel,
  });

  factory Model.fromMap(Map<String, dynamic> json) => Model(
        modelName: json["model_name"],
        price: json["price"],
        diesel: json["diesel"],
      );

  Map<String, dynamic> toMap() => {
        "model_name": modelName,
        "price": price,
        "diesel": diesel,
      };
}
