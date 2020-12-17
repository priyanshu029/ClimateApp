
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey="24eef6308d337548e33e3741dc61316f";

class WeatherModel {


  Future<dynamic> getCityWeather (String cityName) async{

    NetworkHelper b = NetworkHelper('http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    var weatherData =await b.getData();
    return weatherData;


  }

  Future<dynamic> getLocationWeather()async {
    myLocation position = new myLocation();
    await position.getLocation();

    NetworkHelper a = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=${position
            .latitude}&lon=${position.longitude}&appid=$apiKey&units=metric');
    var weatherData = await a.getData();
    return weatherData;
  }


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
