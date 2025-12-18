import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/model/weatherModel.dart';
import 'package:weather/service/weatherService.dart';

class Search extends StatefulWidget {
  final Function(Weather?) onWeatherSearched;

  const Search({super.key, required this.onWeatherSearched});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final WeatherService _weatherService = WeatherService(
    apiKey: dotenv.env['OPEN_WEATHER_API_KEY'] ?? '',
  );

  String? _errorMessage;

  final TextEditingController _controller = TextEditingController();

  void _searchWeather() async {
    final city = _controller.text.trim();

    if (city.isEmpty) {
      setState(() {
        _errorMessage = "Please Enter a City Name";
      });
      return;
    }

    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _errorMessage = null;
      });
      // Pass the weather data back to parent widget
      widget.onWeatherSearched(weather);
    } catch (error) {
      setState(() {
        _errorMessage = 'Could not Find the Data For $city';
      });
      print(error.toString());
      widget.onWeatherSearched(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            //color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.blueAccent.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.shade100.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              hintText: 'Search for a city...',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
              prefixIcon: IconButton(
                icon: Icon(Icons.search_rounded),
                color: Colors.blueAccent[700],
                onPressed: _searchWeather,
              ),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        setState(() {
                          _errorMessage = null;
                        });
                        // Reset to current location
                        widget.onWeatherSearched(null);
                      },
                    )
                  : Lottie.asset(
                      'assets/windy.json',
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            onSubmitted: (value) => _searchWeather(),
          ),
        ),
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _errorMessage!,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
      ],
    );
  }
}
