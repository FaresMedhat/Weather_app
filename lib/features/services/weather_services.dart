import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/features/models/weather_model.dart';

class WeatherServices {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://api.weatherapi.com/v1/current.json?",
      receiveTimeout: (Duration(seconds: 5)),
      connectTimeout: (Duration(seconds: 5)),
    ),
  );

  Future<WeatherModel?> getCurrentWeather({required String city}) async {
    try {
      Response response = await dio.get(
        "key=da98ce5079b841bda25222502252709&q=$city",
      );

      if (response.statusCode == 200) {
        final weather = WeatherModel.fromJson(response.data);
        log("API city: $city");

        return weather;
      } else {
        print("There is an error in response");
        return null;
      }
    } catch (e) {
      print("Error in dio ${e.toString()}");
      return null;
    }
  }
}
