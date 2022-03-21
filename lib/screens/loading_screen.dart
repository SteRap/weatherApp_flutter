import 'package:flutter/material.dart';
import "../services/location.dart";
import '../services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = "ca4fd32202515b318724408312213262";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    getWeatherData();
  }

  void getWeatherData() async {
    Location location = Location();
    await location.determinePosition();
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper("https://api.openweathermap"
        ".org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units"
        "=metric");

    var weatherData = await networkHelper.getData();

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LocationScreen(weatherData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.amberAccent,
          size: 100.0,
        ),
      ),
    );
  }
}
