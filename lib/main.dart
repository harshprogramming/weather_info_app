import 'package:flutter/material.dart';

void main() => runApp(const WeatherInfoApp());

class WeatherInfoApp extends StatelessWidget {
  const WeatherInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Weather App',
      debugShowCheckedModeBanner: false,
      home: const WeatherHome(),
    );
  }
}

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final TextEditingController _cityCtrl = TextEditingController();

  String city = "---";
  String temperature = "---";
  String condition = "---";

  void _fetchWeather() {
    setState(() {
      city = _cityCtrl.text;
      temperature = "Temperature Placeholder";
      condition = "Condition Placeholder";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Info")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _cityCtrl,
              decoration: const InputDecoration(
                labelText: "City",
                hintText: "Enter a city name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: const Text("Fetch Weather"),
            ),
            const SizedBox(height: 24),
            Text("City: $city"),
            Text("Temperature: $temperature"),
            Text("Condition: $condition"),
          ],
        ),
      ),
    );
  }
}
