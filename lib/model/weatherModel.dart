class Weather {
  final String cityName;
  final double temp;
  final String conditon;
  final String description;
  final double pressure;
  final double humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temp,
    required this.conditon,
    required this.description,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
  });

  //metord to convert json data to weather object
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
      conditon: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      pressure: json['main']['pressure'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
