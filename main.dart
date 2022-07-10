import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "WeatherAppRitwik",
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var location = "Kolkata"; // change location from here

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$location&&units=metric&appid=60bbf1a1887b8c69fac034573b3519ce'));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2.7,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    "Currently in $location",
                    style: TextStyle(
                      //fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u0000" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.temperatureHigh,
                      color: Colors.orange[400],
                    ),
                    title: Text("Temparature"),
                    trailing: Text(
                        temp != null ? temp.toString() + "\u0000" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.cloud,
                      color: Colors.blue[200],
                    ),
                    title: Text("Weather"),
                    trailing: Text(description != null
                        ? description.toString()
                        : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.sun,
                      color: Colors.amberAccent,
                    ),
                    title: Text("Humidity"),
                    trailing: Text(
                        humidity != null ? humidity.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.wind,
                      color: Colors.lightBlueAccent,
                    ),
                    title: Text("Wind Speed"),
                    trailing: Text(
                        windSpeed != null ? windSpeed.toString() : "Loading"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
