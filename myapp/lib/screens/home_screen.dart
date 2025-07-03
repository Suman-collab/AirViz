import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState()=>_HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Weather Forecast')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    weatherProvider.fetchWeather(_cityController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            if (weatherProvider.isLoading)
              CircularProgressIndicator()
            else if (weatherProvider.weather != null)
              Column(
                children: [
                  Text(
                    weatherProvider.weather!.cityName,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.network(
                    'https://openweathermap.org/img/wn/${weatherProvider.weather!.iconCode}@2x.png',
                  ),
                  Text(
                    '${weatherProvider.weather!.temperature.toStringAsFixed(1)} °C',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    weatherProvider.weather!.description,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
