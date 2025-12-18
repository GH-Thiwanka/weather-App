/*import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/model/weatherModel.dart';
import 'package:weather/service/weatherService.dart';
import 'package:weather/widget/displayWeather.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/widget/search.dart';

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
  String? _errorMessage;
  bool _isLoading = true;

  // Method to request location permission
  Future<bool> _requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.location.request();
    }

    if (status.isPermanentlyDenied) {
      // Show dialog to open settings
      _showPermissionDialog();
      return false;
    }

    return status.isGranted;
  }

  // Show dialog when permission is permanently denied
  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'This app needs location permission to fetch weather data. Please enable it in settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  // Method to fetch weather
  Future<void> fetchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Request permission first
      bool hasPermission = await _requestLocationPermission();

      if (!hasPermission) {
        setState(() {
          _errorMessage = 'Location permission denied';
          _isLoading = false;
        });
        return;
      }

      final weather = await _weatherService.getWeatherFromLocation();

      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (error) {
      print('Error from weather data: $error');
      setState(() {
        _errorMessage = 'Failed to fetch weather data: $error';
        _isLoading = false;
      });
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
        backgroundColor: Colors.blueAccent.shade100.withOpacity(0.5),
        title: Text(
          'Weather',
          style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 30),
        ),
        actions: [
          IconButton(onPressed: fetchWeather, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.light_mode)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fetchWeather,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _weather != null
              ? Column(
                  children: [
                    Search(),
                    WeatherDisplay(weather: _weather!),
                  ],
                )
              : const Center(child: Text('No weather data available')),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/model/weatherModel.dart';
import 'package:weather/service/weatherService.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/widget/displayWeather.dart';
import 'package:weather/widget/search.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final WeatherService _weatherService = WeatherService(
    apiKey: dotenv.env['OPEN_WEATHER_API_KEY'] ?? '',
  );

  Weather? _currentLocationWeather;
  Weather? _searchedWeather;
  String? _errorMessage;
  bool _isLoading = true;

  // Method to request location permission
  Future<bool> _requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.location.request();
    }

    if (status.isPermanentlyDenied) {
      _showPermissionDialog();
      return false;
    }

    return status.isGranted;
  }

  // Show dialog when permission is permanently denied
  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'This app needs location permission to fetch weather data. Please enable it in settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  // Method to fetch weather for current location
  Future<void> fetchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      bool hasPermission = await _requestLocationPermission();

      if (!hasPermission) {
        setState(() {
          _errorMessage = 'Location permission denied';
          _isLoading = false;
        });
        return;
      }

      final weather = await _weatherService.getWeatherFromLocation();

      setState(() {
        _currentLocationWeather = weather;
        _searchedWeather = null; // Reset searched weather
        _isLoading = false;
      });
    } catch (error) {
      print('Error from weather data: $error');
      setState(() {
        _errorMessage = 'Failed to fetch weather data: $error';
        _isLoading = false;
      });
    }
  }

  // Handle search results
  void _handleWeatherSearch(Weather? weather) {
    setState(() {
      if (weather != null) {
        _searchedWeather = weather;
      } else {
        _searchedWeather = null;
      }
    });
  }

  // Get the weather to display (searched weather takes priority)
  Weather? get _displayWeather => _searchedWeather ?? _currentLocationWeather;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100.withOpacity(0.5),
        title: const Text(
          'Weather',
          style: TextStyle(fontWeight: FontWeight.w200, fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: fetchWeather,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh current location',
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.light_mode)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // Search bar always visible
              Search(onWeatherSearched: _handleWeatherSearch),
              const SizedBox(height: 10),

              // Weather display
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 60,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: fetchWeather,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  : _displayWeather != null
                  ? WeatherDisplay(weather: _displayWeather!)
                  : const Center(child: Text('No weather data available')),
            ],
          ),
        ),
      ),
    );
  }
}
