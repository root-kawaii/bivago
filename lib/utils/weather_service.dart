import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '25f049baebf64298afaec98ecfebb953';

  Future<Map<String, dynamic>> fetchWeather(double lat1, double lon1) async {
    print(lat1);
    print(lon1);
    int lat = lat1.floor();
    int lon = lon1.floor();
    print(
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=25f049baebf64298afaec98ecfebb953');
    final response = await http.get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=25f049baebf64298afaec98ecfebb953'),
    );

    if (response.statusCode == 200) {
      print('ciao');
      return json.decode(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load weather data');
    }
  }
}

// api.openweathermap.org/data/2.5/weather?q=peshawar&appid=25f049baebf64298afaec98ecfebb953