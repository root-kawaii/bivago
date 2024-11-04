import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bivago/pages/home.dart';
import 'package:bivago/themes/colors_theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../utils/location_service.dart';
import '../utils/weather_service.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:bivago/pages/singleView.dart';

class NewsAndWeatherPage extends StatefulWidget {
  const NewsAndWeatherPage({super.key});

  @override
  _NewsAndWeatherPageState createState() => _NewsAndWeatherPageState();
}

class _NewsAndWeatherPageState extends State<NewsAndWeatherPage> {
  String location = "Loading...";
  Position? position;
  String weather = "Loading...";
  List<String> news = ["Loading..."];
  var weatherIcon = WeatherIcons.cloud;
  bool weatherIconLoading = true;
  int temperature = 0;

  @override
  void initState() {
    super.initState();
    // _fetchData();
    _getCurrentLocation();
    _getWeather();
  }

  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();
  String _weatherInfo = 'Fetching weather...';

  Future<void> _getWeather() async {
    try {
      Position pos = await _locationService.getCurrentLocation();
      position = pos;
      Map<String, dynamic> weatherData =
          await _weatherService.fetchWeather(pos.latitude, pos.longitude);

      weatherIcon = _getWeatherIcon(weatherData['weather'][0]['description']);

      setState(() {
        _weatherInfo =
            'Temperature: ${(weatherData['main']['temp'] - 273).floor()}C\n'
            'Description: ${weatherData['weather'][0]['description']}';
        weatherIconLoading = false;
        temperature = (weatherData['main']['temp'] - 273).floor();
      });
    } catch (e) {
      print(e);
      setState(() {
        _weatherInfo = 'Error: $e';
      });
    }
  }

  IconData _getWeatherIcon(String condition) {
    if (condition == "clear sky") {
      return WeatherIcons.day_sunny;
    } else if (condition == "few clouds") {
      return WeatherIcons.cloud;
    } else if (condition == "overcast clouds") {
      return WeatherIcons.day_sunny_overcast;
    } else if (condition == "clear sky") {
      return WeatherIcons.day_sunny;
    } else if (condition == "shower rain") {
      return WeatherIcons.showers;
    } else if (condition == "rain") {
      return WeatherIcons.rain;
    } else if (condition == "thunderstorm") {
      return WeatherIcons.thunderstorm;
    } else if (condition == "snow") {
      return WeatherIcons.snow;
    } else if (condition == "mist") {
      return WeatherIcons.fog;
    } else {
      return WeatherIcons.day_sunny;
    }
  }

  // Future<void> _fetchData() async {
  //   await _getCurrentLocation();
  //   await _getWeather();
  //   await _getNews();
  // }

  Future<String> getAddress() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String user = prefs.getString('location') ?? "Unknowns";
      return user;
    } catch (e) {
      print('Error: $e');
      return 'Unknown';
    }
  }

  Future<void> _getCurrentLocation() async {
    print("getting locatin");
    var locationTemp = await getAddress();
    setState(() {
      location = locationTemp; // Mock city
    });
  }

  Future<void> _getNews() async {
    // Mock news data
    setState(() {
      news = [
        "Headline 1: Example news item",
        "Headline 2: Another news item",
        "Headline 3: Yet another news item",
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_weatherInfo),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  location,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark),
                ),
                weatherIconLoading == true
                    ? Column(children: [
                        SizedBox(
                          height: screenHeight * 0.035,
                        ),
                        const CircularProgressIndicator(),
                        Text(
                          temperature.toString(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        )
                      ])
                    : Column(children: [
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Icon(
                          weatherIcon,
                          size: 48,
                          color: ThemeColor.orange,
                        ),
                        Text(
                          temperature.toString(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        )
                      ])
              ],
            ),
            // Text(
            //   weather,
            //   style: TextStyle(fontSize: 18, color: Colors.grey),
            // ),
            // SizedBox(height: 10),
            Text(
              DateFormat('d MMMM y').format(now),
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),

            Text(
              DateFormat('hh:mm a').format(now),
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: const Text(
                "Esercizio fiume a Siracusa",
                style: TextStyle(fontSize: 16, color: Colors.yellow),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return ExpandableCard(
                      // margin: EdgeInsets.symmetric(vertical: 8.0),
                      // child: Padding(
                      //   padding: EdgeInsets.all(16.0),
                      //   child: Text(
                      //     news[index],
                      //     style: TextStyle(fontSize: 16),
                      //   ),
                      // ),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableCard extends StatefulWidget {
  const ExpandableCard({super.key});

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _iconRotation;
  late Animation<double> _iconRotation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _iconRotation = Tween<double>(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _iconRotation2 =
        Tween<double>(begin: 0.5, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpanded,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(10),
          height: _isExpanded ? 250 : 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 75.0,
                  maxHeight: 75.0,
                ),
                child: InkWell(
                  child: const Text(
                    'Russia, China absent as world leaders meet for Ukraine peace conference',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          TourismPage(cardID: 0),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ));
                  },
                ),
              ),
              // if (_isExpanded)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Image.asset('assets/images/logo_1.png'),
                  ),
                ),
              ),
              // if (!_isExpanded)
              Center(
                child: RotationTransition(
                  turns: _iconRotation,
                  child: GestureDetector(
                    onTap: _toggleExpanded,
                    child: const Icon(
                      Icons.expand_more,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              // if (_isExpanded)
              //   Center(
              //     child: RotationTransition(
              //       turns: _iconRotation2,
              //       child: GestureDetector(
              //         onTap: _toggleExpanded,
              //         child: Icon(
              //           Icons.expand_less,
              //           size: 30,
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPageRouteBuilder<T> extends PageRoute<T> {
  final RoutePageBuilder pageBuilder;
  final PageTransitionsBuilder matchingBuilder = Platform.isIOS
      ? const CupertinoPageTransitionsBuilder()
      : const FadeUpwardsPageTransitionsBuilder(); // Default iOS/macOS (to get the swipe right to go back gesture)
  // final PageTransitionsBuilder matchingBuilder = const FadeUpwardsPageTransitionsBuilder(); // Default Android/Linux/Windows

  CustomPageRouteBuilder({required this.pageBuilder});

  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => "null";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return pageBuilder(context, animation, secondaryAnimation);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(
      milliseconds:
          500); // Can give custom Duration, unlike in MaterialPageRoute

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 500);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return matchingBuilder.buildTransitions<T>(
        this, context, animation, secondaryAnimation, child);
  }
}
