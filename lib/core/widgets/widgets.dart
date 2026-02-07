import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/searche_screen/search_screen.dart';

class TextOfDetails extends StatelessWidget {
  const TextOfDetails({
    super.key,
    required this.temp,
    required this.tempColor,
    required this.fontSize,
  });

  final double temp;
  final Color tempColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$temp°",
      style: TextStyle(
        fontSize: fontSize,
        color: tempColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TextDetails extends StatelessWidget {
  const TextDetails({
    super.key,
    required this.size,
    required this.text,
    required this.colorOfText,
  });
  final double size;
  final String text;
  final Color colorOfText;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: colorOfText,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.colorOfState,
    required this.tempColor,
    required this.icon,
    required this.temp,
    required this.state,
    required this.city,
  });

  final Color colorOfState;
  final Color tempColor;
  final Image icon;
  final double temp;
  final String state;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.8 * MediaQuery.of(context).size.width,
      height: 0.4 * MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: colorOfState,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            DateFormat('EEEE').format(DateTime.now()),
            style: TextStyle(
              fontSize: 30,
              color: tempColor,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: GoogleFonts.overpass().fontFamily,
            ),
          ),
          Row(
            children: [
              Container(
                width: 0.14 * MediaQuery.of(context).size.width,
                height: 0.12 * MediaQuery.of(context).size.height,
                margin: EdgeInsets.fromLTRB(60, 0, 15, 0),
                child: Image(image: icon.image),
              ),
              TextOfDetails(temp: temp, tempColor: tempColor, fontSize: 65),
            ],
          ),
          TextDetails(size: 25, text: state, colorOfText: tempColor),
          TextDetails(size: 20, text: city, colorOfText: tempColor),

          TextDetails(
            text: DateFormat.yMMMMd().format(DateTime.now()),
            size: 20,
            colorOfText: tempColor,
          ),
        ],
      ),
    );
  }
}

class SplashScreenTexts extends StatelessWidget {
  const SplashScreenTexts({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "$text",
        style: TextStyle(
          fontSize: 64,
          color: Color(0xFF0093D1),
          shadows: [
            Shadow(
              color: Color(0x1A000000),
              offset: Offset(-4, 8),
              blurRadius: 20,
            ),
          ],
          fontFamily: GoogleFonts.overpass().fontFamily,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class FailedWidgateee extends StatelessWidget {
  const FailedWidgateee({super.key, required this.hight1});

  final double hight1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 0.03 * hight1),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },

                icon: Icon(size: 38, Icons.search),
                highlightColor: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 0.2 * hight1),
          Text("There is an error , please try again "),
        ],
      ),
    );
  }
}
