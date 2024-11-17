import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String apiKey = '800e647167cc41cc21273962576c08bc';

  Future<Map<String, dynamic>> fetchWeatherData(String city) async {
    try {
      // Fetch data from OpenWeatherMap API
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
