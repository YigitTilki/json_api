import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_api/model/car_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({super.key});

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  Future<List<Car>> readCarsJson() async {
    try {
      debugPrint("5 second process starting");
      await Future.delayed(const Duration(seconds: 5), () {
        debugPrint("5 second process end");
      });
      // ignore: use_build_context_synchronously
      String readString = await DefaultAssetBundle.of(context)
          .loadString("assets/data/cars.json");

      var jsonArray = jsonDecode(readString);
      /*debugPrint(readString);
    debugPrint("**********************");
    List carList = jsonObject;
    debugPrint(carList[0]["model"][0]["price"].toString());*/

      List<Car> allCars = (jsonArray as List)
          .map(
            (carMap) => Car.fromMap(carMap),
          )
          .toList();
      debugPrint(allCars.length.toString());
      debugPrint(allCars[0].model[0].diesel.toString());

      return allCars;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }

  late final Future<List<Car>> _fillList;

  String _title = "Local Json Process";
  @override
  void initState() {
    super.initState();
    _fillList = readCarsJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          _title = "Button Pressed";
        });
      }),
      body: FutureBuilder<List<Car>>(
        future: _fillList,
        initialData: [
          Car(
            carName: "aaa",
            country: "dsds",
            since: 1920,
            model: [
              Model(modelName: "vvvv", price: 15620, diesel: true),
            ],
          ),
        ],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Car> carList = snapshot.data!;
            return ListView.builder(
              itemCount: carList.length,
              itemBuilder: (context, index) {
                Car currentCar = carList[index];
                return ListTile(
                  title: Text(currentCar.carName),
                  subtitle: Text(currentCar.country),
                  leading: CircleAvatar(
                    child: Text(currentCar.model[0].modelName),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
