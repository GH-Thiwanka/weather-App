class UtilFunction {
  //function to get the weather animation based on the weather condition
  String getWeatherAnimation({required String condition}) {
    switch (condition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
      case 'dust':
        return 'assets/mist.json';

      case 'rain':
      case 'dizzle':
      case 'shower rain':
        return 'assets/rainstorm.json';

      case 'thunderstorm':
        return 'assets/thunderstorm.json';

      case 'Clear':
        return 'assets/sunny.json';

      default:
        return 'assets/sunny.json';
    }
  }
}
