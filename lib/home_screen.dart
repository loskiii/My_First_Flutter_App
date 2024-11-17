import 'package:flutter/material.dart';
import 'weather_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? weatherData;
  String city = 'Nairobi';
  final TextEditingController _controller = TextEditingController();

  Future<void> fetchWeather(String cityName) async {
    try {
      final data = await _weatherService.fetchWeatherData(cityName);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print('Error fetching weather: $e');
      setState(() {
        weatherData = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      fetchWeather(_controller.text);
                    }
                  },
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) fetchWeather(value);
              },
            ),
          ),
          weatherData != null
              ? Expanded(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              color: weatherData!['main']['temp'] > 20
                  ? Colors.orangeAccent
                  : Colors.blueAccent,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'City: ${weatherData!['name']}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text(
                      'Temperature: ${weatherData!['main']['temp']}°C',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Description: ${weatherData!['weather'][0]['description']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          )
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
