import 'package:http/http.dart' as http;
import 'dart:convert';

enum WeatherCondition { sun, rain, other }

class Weather {
  WeatherCondition condition;
  double temperature;
  int SUNNY_CLOUD_LIMIT = 30;

  Weather(WeatherCondition condition, double temperature) {
    this.condition = condition;
    this.temperature = temperature;
  }

  Weather.fromJson(Map<String, dynamic> json) {
    var mainWeather = json['list'][0]['weather'][0]['main'];  //Clear, Rain, Snow, Sun, Clouds...
    var cloudiness = json['list'][0]['clouds']['all'];  //Percentage 0-100

    print('weather: $mainWeather');
    print('cloudiness: $cloudiness');

    WeatherCondition condition = WeatherCondition.other;
    if (mainWeather == "Clear") {
      condition = WeatherCondition.sun;
    } else if (mainWeather == "Clouds" && cloudiness < SUNNY_CLOUD_LIMIT ) {
      condition = WeatherCondition.sun;
    }
    else if (mainWeather == "Rain") {
      condition = WeatherCondition.rain;
    }
    this.condition = condition;
    this.temperature = json['list'][0]['main']['temp'];
  }
}

class WeatherService {
  static final String apiEndpoint = "https://api.openweathermap.org/data/2.5/forecast";

  static Future<Weather> get (double lat, double lon) async {
    final String query = "?lat=$lat&lon=$lon&units=metric&appid=00753a867986ffd277953b9c955278f8";
    var url = apiEndpoint + query;
    var response = await http.get(url);
    Map<String, dynamic> json = jsonDecode(response.body);
    return new Weather.fromJson(json);
  }
}

