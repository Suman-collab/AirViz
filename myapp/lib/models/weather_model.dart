
class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final int sunrise;
  final int sunset;
  final double windspeed;
  final int humidity;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.sunrise,
    required this.humidity,
    required this.sunset,
    required this.windspeed
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'] -273.15,
      description: json['weather']['description'], 
      sunrise: json['sys']['sunrise'], 
      humidity: json['main']['humidity'], 
      sunset: json['sys']['sunset'], 
      windspeed: json['wind']['winspeed'],
    );
  }

  get iconCode => null;
}
