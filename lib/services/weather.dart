import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '41a5c4989b496211d369c6c7830b880d';
const URL = '';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric',
        'https://api.openweathermap.org/data/2.5/onecall?&q=$cityName&exclude=hourly,daily,minutely&appid=41a5c4989b496211d369c6c7830b880d');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
        'https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,daily,minutely&appid=41a5c4989b496211d369c6c7830b880d');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  // Future<dynamic> getExtraLocationWeather() async {
  //   Location location = Location();
  //   await location.getCurrentLocation();
  //   NetworkHelperExtra networkHelperExtra = NetworkHelperExtra(
  //       'https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,daily,minutely&appid=41a5c4989b496211d369c6c7830b880d');
  //   var weatherExtraData = await networkHelperExtra.getExtraData();
  // }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
