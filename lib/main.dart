import 'package:flutter/material.dart';
import 'package:gearapp/ui/sun_image.dart';
import 'package:gearapp/weatherService.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gear App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Gear App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Weather _weather;

  @override
  void initState() {
    this._load();
  }

  Future<void> _load() async {
    try {
      var locationService = new Location();
      var location = await locationService.getLocation();
      var lat = location['latitude'];
      var lon = location['longitude'];
      print('Lat: $lat, Lon: $lon');
      var weather = await WeatherService.get(lat, lon);
      // var weather = await WeatherService.get(59.3251, 18.0711); // Stockholm
      print(weather.condition);
      setState(() {
         _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'What should I wear?',
              style: Theme.of(context).textTheme.display1,
            ),
            this._weather != null
              ? Row(children: <Widget> [SunImage(this._weather), Text('+', style: TextStyle(fontSize: 50)), TemperatureImage(this._weather)], mainAxisAlignment: MainAxisAlignment.spaceEvenly,)
              : null
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _load,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
