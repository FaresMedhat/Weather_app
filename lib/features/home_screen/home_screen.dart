import 'dart:math' hide log;

import 'package:flutter/material.dart';

import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/core/colors/colors.dart';
import 'package:weather_app/core/cubit/weather_logic_cubit.dart';
import 'package:weather_app/core/cubit/weather_state.dart';
import 'package:weather_app/core/widgets/widgets.dart';
import 'package:weather_app/features/models/hive_model.dart';
import 'package:weather_app/features/models/weather_model.dart';
import 'package:weather_app/features/searche_screen/search_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String NameOfCity = HiveModel().getCityName() ?? "cairo";
    context.read<WeatherLogicCubit>().getWeatherData(city: NameOfCity);
    var hight1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    var date = DateTime.now();
    String dayNameFull = DateFormat('EEEE').format(date);
    var mycubit = context.read<WeatherLogicCubit>();
    return Scaffold(
      body: BlocBuilder<WeatherLogicCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherIsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherIsLoaded) {
            try {
              WeatherModel? weatherModel = state.weatherModel;
              double temp = weatherModel?.temp ?? 0.0;
              final condition = weatherModel?.state.toLowerCase().trim() ?? "";
              late Image backgroundImage;
              late Image icon;
              late Color colorOfState;
              late Color tempColor;
              if (condition.contains("sun")) {
                colorOfState = ColorsOfTemperatures().sunnyColor;
                tempColor = ColorsOfTemperatures().sunnyTempColor;
                backgroundImage = Image.asset("assets/sunny.png");
                icon = Image.asset("assets/sunny_icon.png");
              } else if (condition.contains("cloud")) {
                colorOfState = ColorsOfTemperatures().claudyColor;
                tempColor = ColorsOfTemperatures().claudyTempColor;
                backgroundImage = Image.asset("assets/cloudy2.png");
                icon = Image.asset("assets/cloudy_icon2.png");
              } else if (condition.contains("rain")) {
                colorOfState = ColorsOfTemperatures().rainyTempColor;
                tempColor = ColorsOfTemperatures().rainyColor;
                backgroundImage = Image.asset("assets/rainy.png");
                icon = Image.asset("assets/rainy_icon.png");
              } else if (condition.contains("snow")) {
                colorOfState = ColorsOfTemperatures().snowColor;
                tempColor = ColorsOfTemperatures().snowTempColor;
                backgroundImage = Image.asset("assets/snowy.png");
                icon = Image.asset("assets/snowy_icon.png");
              } else {
                colorOfState = ColorsOfTemperatures().cleanColor;
                tempColor = ColorsOfTemperatures().cleanTempColor;
                backgroundImage = Image.asset("assets/clean.png");
                icon = Image.asset("assets/clean_icon.png");
              }
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: backgroundImage.image,
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 0.03 * hight1),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ),
                              );
                            },

                            icon: Icon(size: 38, Icons.search),
                            highlightColor: Colors.grey,
                          ),
                        ],
                      ),
                      Details(
                        colorOfState: colorOfState,
                        tempColor: tempColor,
                        icon: icon,
                        temp: temp,
                        state: weatherModel?.state ?? "Unknown",
                        city: NameOfCity,
                      ),
                    ],
                  ),
                ),
              );
            } catch (e) {
              log("Error rendering weather: $e");
              return const Center(child: Text("Error displaying weather"));
            }
          }
          return FailedWidgateee(hight1: hight1);
        },
      ),
    );
  }
}
