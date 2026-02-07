import 'package:flutter/material.dart';

class WeatherModel {
  final double temp;
  final String state;
  final String iconOfState;
  final nameOfCity;
  final double windSpeed;
  final int humidity;
  final double precip_mm; // rain in mm

  WeatherModel({
    required this.temp,
    required this.state,
    required this.iconOfState,
    required this.nameOfCity,
    required this.windSpeed,
    required this.humidity,
    required this.precip_mm,
  });
  //from json
  factory WeatherModel.fromJson(json) {
    return WeatherModel(
      temp: json["current"]["temp_c"],
      state: json["current"]["condition"]["text"],
      iconOfState: json["current"]["condition"]["icon"],
      nameOfCity: json["location"]["name"],
      windSpeed: json["current"]["wind_kph"],
      humidity: json["current"]["humidity"],
      precip_mm: json["current"]["precip_mm"],
    );
  }
}
