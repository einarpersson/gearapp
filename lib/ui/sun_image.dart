import 'package:flutter/material.dart';
import 'package:gearapp/weatherService.dart';

class SunImage extends StatelessWidget {
  Weather _weather;

  SunImage (Weather weather) {
    _weather = weather;
  }

  Widget _imageForWeather (Weather weather) {
    switch (weather.condition) {
      case WeatherCondition.sun:
        return Image.asset('images/sun-glasses.png');
      case WeatherCondition.rain:
        return Image.asset('images/umbrella.png');
      default:
        return Text('¯\\_(ツ)_/¯', style: TextStyle(fontSize: 40),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: this._imageForWeather(this._weather), width: 100, height: 100,);
  }
}
