import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather, this.extraLocationWeather});
  final locationWeather;
  final extraLocationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String main;
  String city;
  String weatherIcon;
  String message;
  num windSpeed; //Here num is use because the the data fluctuate between int and double and getting error
  int pressure;
  int minTemp;
  int maxTemp;
  int humidity;
  int feelsLike;
  int uV;

  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    print(widget.extraLocationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'E';
        message = 'Unable to get Data';
        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      // double feelslike = weatherData['main']['feels_like'];
      // feelsLike = temp.toInt();
      // print(feelsLike);

      double mintemp = weatherData['main']['temp_min'];
      minTemp = mintemp.toInt();

      double maxtemp = weatherData['main']['temp_max'];
      maxTemp = maxtemp.toInt();

      // uV = weatherData['current']['uvi'];
      // print(uV);

      // double wind = weatherData['wind']['speed'];
      // windSpeed = wind.toInt();

      windSpeed = weatherData['wind']['speed'];
      pressure = weatherData['main']['pressure'];

      humidity = weatherData['main']['humidity'];

      main = weatherData['weather'][0]['description'];
      var condition = weatherData['weather'][0]['id'];
      //print(condition);

      weatherIcon = weather.getWeatherIcon(condition);
      //message = weather.getMessage(temperature);

      city = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/Nature Abstract Super Amoled Wallpaper Full.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                      print('Button 1 pressed');
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$city',
                      style: kMessageTextStyle,
                    ),
                    Row(
                      children: [
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          '$weatherIcon', //'☀️'
                          style: kConditionTextStyle,
                        ),
                        Text(
                          '  L:$minTemp°',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '  H:$maxTemp°',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      ('Wind $windSpeed kph'),
                      style: kWindTextStyle,
                    ),
                    Text(
                      ('Pressure $pressure hPa'),
                      style: kWindTextStyle,
                    ),
                    Text(
                      ('Humidity $humidity %'),
                      style: kWindTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$main', //"It's 🍦 time in your Location!"
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
