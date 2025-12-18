//import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/model/weatherModel.dart';
import 'package:weather/service/weatherService.dart';
import 'package:weather/widget/displayWeather.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final WeatherService _weatherService = WeatherService(
    apiKey: dotenv.env['OPEN_WEATHER_API_KEY'] ?? '',
  );

  Weather? _weather;

  //methord to fetch weather
  void fetchWeather() async {
    try {
      final weather = await _weatherService.getWeatherFromLocation();

      setState(() {
        _weather = weather;
      });
    } catch (error) {
      print('Error from weater data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _weather?.cityName ?? '',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.light_mode))],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: _weather != null
            ? Column(children: [WeatherDisplay(weather: _weather!)])
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
