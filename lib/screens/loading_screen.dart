import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    super.initState();
    _getLocationData();

  }

  void _getLocationData()async{

    var weatherData = await WeatherModel().getLocationWeather();
    await Future.delayed(Duration(seconds: 6));
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherData,);
    }));
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: Colors.white,
        child:Center(
          child: TextLiquidFill(
            text: 'WEATHER',
            waveColor: Colors.blueAccent,
            boxBackgroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
            boxHeight: 300.0,
          ),
        ),
      ),
    );
  }
}


//SpinKitChasingDots(
//color: Colors.white,
//size: 50.0,
//),