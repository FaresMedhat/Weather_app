import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/cubit/weather_state.dart';
import 'package:weather_app/features/models/hive_model.dart';
import 'package:weather_app/features/models/weather_model.dart';
import 'package:weather_app/features/services/weather_services.dart';

class WeatherLogicCubit extends Cubit<WeatherState> {
  final WeatherServices weatherServices;
  WeatherLogicCubit(this.weatherServices) : super(WeatherIntial());

  Future<void> getWeatherData({required String city}) async {
    emit(WeatherIsLoading());

    try {
      log("loading weather data");
      WeatherModel? weatherModel = await weatherServices.getCurrentWeather(
        city: city,
      );
      if (weatherModel != null) {
        log("Weather Temp for : ${weatherModel.temp}"); // هنا نتأكد من البيانات
        log("Weather Condition: ${weatherModel.state}");
        emit(WeatherIsLoaded(weatherModel: weatherModel));
      } else {
        log("Failed to load data");
        log(weatherModel.toString());

        emit(WeatherFailure(errorMessage: "Failed to load weather data"));
      }
    } catch (e) {
      emit(WeatherFailure(errorMessage: e.toString()));
    }
  }
}
