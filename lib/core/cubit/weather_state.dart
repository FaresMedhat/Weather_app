import 'package:weather_app/features/models/weather_model.dart';

class WeatherState {}

class WeatherIntial extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  WeatherModel? weatherModel;
  WeatherIsLoaded({this.weatherModel});
}

class WeatherIsClean extends WeatherState {}

class WeatherIsClouded extends WeatherState {}

class WeatherIsSunny extends WeatherState {}

class WeatherIsRaining extends WeatherState {}

class WeatherIsSnowing extends WeatherState {}

class WeatherFailure extends WeatherState {
  String? errorMessage;
  WeatherFailure({this.errorMessage});
}
