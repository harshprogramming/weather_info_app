import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const WeatherInfoApp());

class WeatherInfoApp extends StatelessWidget {
  const WeatherInfoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Information',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
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
  String? city;
  int? tempC;
  String? condition;

  final _rng = Random();
  final _conditions = ["Sunny", "Cloudy", "Rainy"];

  void _fetchToday() {
    final input = _cityCtrl.text.trim();
    if (input.isEmpty) return;
    setState(() {
      city = input;
      tempC = 15 + _rng.nextInt(16);
      condition = _conditions[_rng.nextInt(_conditions.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Today\'s Weather')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _cityCtrl,
              decoration: const InputDecoration(
                labelText: "City",
                hintText: "Enter a city",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _fetchToday,
              child: const Text("Fetch Weather"),
            ),
            const SizedBox(height: 24),
            if (city != null && tempC != null && condition != null) ...[
              Card(
                child: ListTile(
                  title: Text("$tempC°C  •  $condition"),
                  subtitle: Text(city!),
                  
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
