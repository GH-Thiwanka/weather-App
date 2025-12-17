import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Getlocationservice {
  Future<String> getCityNameFromCurrentLocation() async {
    //get the permssion from the user to access the location
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );
    print(position.latitude);
    print(position.longitude);

    //convert the location in to list of place marks
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    //extract the city name from the place marks
    String cityName = placeMarks[0].locality!;
    print(cityName);

    return cityName;
  }
}
