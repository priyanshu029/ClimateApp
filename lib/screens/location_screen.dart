//import 'package:clima/old%20data/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
import 'package:weather_widget/WeatherWidget.dart';
import 'loading_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int temperature;
  int condition;
  String cityName;

  Map weather = {
    800 : 'Sunny',
    6 : 'Snowy',
    2 : 'Thunder',
    5 : 'Rainy',
    8 : 'Cloudy'
  };

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        condition = 0;
        cityName = 'error';
      } else {
        dynamic temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        condition = weatherData['weather'][0]['id'];
        cityName = weatherData['name'];
        print(temperature);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              WeatherWidget(
                weather: weather[condition/100],
                size: Size(50, 50),
                sunConfig: SunConfig(),
                cloudConfig: CloudConfig(),
                rainConfig: RainConfig(
                    rainCurve: Curves.decelerate,
                    rainNum: 50,
                    rainLength: 5.0,
                    rainWidth: 5.0,
                    rainColor: Colors.blueGrey),
                snowConfig: SnowConfig(
                  snowNum: 15,
                ),
                thunderConfig: ThunderConfig(
                  thunderWidth: 3.0,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          var weatherData =
                              await weatherModel.getLocationWeather();
                          Navigator.push(context,MaterialPageRoute(builder: (context){
                            return LoadingScreen();
                          }));
//                          updateUI(weatherData);
//                          Navigator.push(context,MaterialPageRoute(builder: (context){
//                            return LocationScreen(locationWeather: weatherData,);
//                          }));
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
                          var weatherData =
                              await weatherModel.getCityWeather(typedName);
                          updateUI(weatherData);
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
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherModel.getWeatherIcon(condition),
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text(
                      '${weatherModel.getMessage(temperature)} in $cityName !',
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//'☀️'
