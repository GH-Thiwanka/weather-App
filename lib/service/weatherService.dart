import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:weather/model/weatherModel.dart';
import 'package:http/http.dart' as http;
import 'package:weather/service/getlocationService.dart';

class WeatherService {
  //https://api.openweathermap.org/data/2.5/weather?q=London&appid=c08161133c89dcc4df57dabe7d73c559&units=metric

  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService({required this.apiKey});

  //get the weather from the city name
  Future<Weather> getWeather(String cityName) async {
    try {
      final url = '$BASE_URL?q=$cityName&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception('Faild to load the weather data');
      }
    } catch (error) {
      throw Exception('Faild to load the weather data');
    }
  }

  //get the weather from current location
  Future<Weather> getWeatherFromLocation() async {
    try {
      final location = Getlocationservice();
      final cityName = await location.getCityNameFromCurrentLocation();

      final url = '$BASE_URL?q=$cityName&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception('Faild to load the weather data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Faild to load the weather data');
    }
  }
}
