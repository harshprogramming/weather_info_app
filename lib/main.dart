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

  List<DayForecast> forecast = [];

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

  void _fetch7Day() {
    final input = _cityCtrl.text.trim();
    if (input.isEmpty) return;

    final List<DayForecast> days = List.generate(7, (i) {
      final date = DateTime.now().add(Duration(days: i + 1));
      final t = 15 + _rng.nextInt(16);
      final c = _conditions[_rng.nextInt(_conditions.length)];
      return DayForecast(city: input, date: date, tempC: t, condition: c);
    });

    setState(() {
      city = input;
      forecast = days;
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

            const Divider(height: 40),

            FilledButton.tonal(
              onPressed: _fetch7Day,
              child: const Text("Fetch 7-Day Forecast"),
            ),
            const SizedBox(height: 12),

            if (forecast.isNotEmpty) ...[
              Text("7-Day Forecast for ${forecast.first.city}",
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              for (final d in forecast)
                Card(
                  child: ListTile(
                    title: Text("${d.tempC}°C  •  ${d.condition}"),
                    subtitle: Text(d.city),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class DayForecast {
  final String city;
  final DateTime date;
  final int tempC;
  final String condition;

  DayForecast({
    required this.city,
    required this.date,
    required this.tempC,
    required this.condition,
  });
}