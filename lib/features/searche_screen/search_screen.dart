import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/cubit/weather_logic_cubit.dart';
import 'package:weather_app/features/models/hive_model.dart';
import 'package:weather_app/features/models/weather_model.dart';
import 'package:weather_app/features/services/weather_services.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController cityName = TextEditingController();
  HiveModel hiveModel = HiveModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, cityName);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Search"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
              child: TextField(
                onSubmitted: (value) async {},
                controller: cityName,
                decoration: InputDecoration(
                  hintText: "Search city",
                  label: Text("Search"),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {
                      String city = cityName.text.toString();
                      hiveModel.saveCityName(cityName.text.toString());
                      if (city.isNotEmpty) {
                        var weather = BlocProvider.of<WeatherLogicCubit>(
                          context,
                        );
                        weather.getWeatherData(city: hiveModel.getCityName()!);
                        log("$city is saved");
                        log("Search returning city: $city");
                        Navigator.pop(context);
                      } else {
                        log("City name is empty");
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
