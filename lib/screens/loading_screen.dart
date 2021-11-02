import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat;
  double long;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  // void getExtraData() async {
  //   var weatherData = await WeatherModel().getExtraLocationData();
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return LocationScreen(
  //       locationWeather: weatherData,
  //     );
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

//void getExtraLocationData() async {
//     Location location = Location();
//     await location.getCurrentLocation();
//     latitude = location.latitude;
//     longitude = location.longitude;
//     NetworkHelper networkHelper = NetworkHelper(
//         'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=hourly,minutely,daily&appid=41a5c4989b496211d369c6c7830b880d');
//     var weatherData = networkHelper.getextraData();
//   }

//var uV = jsonDecode(data)['current']['uvi'];
