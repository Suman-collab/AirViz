import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weatherservices.dart';

class WeatherProvider with ChangeNotifier {
  Weather? weather;
  bool isLoading = false;

  Future<void> getWeather(String city) async {
    isLoading = true;
    notifyListeners();

    try {
      weather = await WeatherApiService().fetchWeather(city);
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchWeather(String text) {}
}
