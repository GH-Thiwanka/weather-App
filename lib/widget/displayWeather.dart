import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/model/weatherModel.dart';
import 'package:weather/utils/utilFunction.dart';
import 'package:weather/widget/search.dart';
import 'package:weather/widget/weatherDetails.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;
  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width:
                  MediaQuery.of(context).size.width * 0.96, // Responsive width
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0099FF), Color(0xFF1444DD)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: Text(
                      weather.cityName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 35,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Center(
                          child: Lottie.asset(
                            UtilFunction().getWeatherAnimation(
                              condition: weather.conditon,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${weather.temp.toStringAsFixed(1)}°C',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            '${weather.description}',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Weatherdetails(
                          lable: 'Pressure',
                          value: weather.pressure.toStringAsFixed(2),
                          detail: 'assets/windy.json',
                        ),
                        Weatherdetails(
                          lable: 'Humidity',
                          value: weather.humidity.toStringAsFixed(1),
                          detail: 'assets/rainstorm.json',
                        ),
                        Weatherdetails(
                          lable: 'Wind Speed',
                          value: weather.windSpeed.toStringAsFixed(1),
                          detail: 'assets/mist.json',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
