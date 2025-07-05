import 'package:flutter/material.dart';
import 'package:myapp/models/weather_model.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final weatherservices _weatherservices = WeatherServices();

  final TextEditingController _controller = TextEditingController();
  _isloading = false;
  Weather? _weather;
  void _getweather() async {
    setState(() {
      _isloading = true;
    });
    try{

      final Weather = await _weatherservices.featchweather(_controller.text);
      setState(() {
        _weather= weather;
        _isloading=false;
      });
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error fetching weather data')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:_weather !=null && _weather!.description.toLowerCase().contains('rain')
            ? const LinearGradient(
            colors: [Colors.grey,Colors.limeAccent],
            begin: Alignment.topCenter,
            end: Alignment.center,
            )
            : _weather !=null && _weather!.description.toLowerCase().contains('clear')
            ? const LinearGradient(
            colors: [Colors.black,Colors.redAccent],
            begin: Alignment.center,
            end: Alignment.topLeft,
            )
            :  const LinearGradient(
            colors: [Colors.lightBlueAccent,Colors.deepOrangeAccent],
            begin: Alignment.bottomRight,
            end: Alignment.centerRight,
            ) 
          
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 25,),
                Text(
                  'weather app',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                  ),



                    SizedBox(height: 45,),
                    TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "enter your city",
                        hintStyle: TextStyle(color: Colors.amber),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 247, 8, 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(34),
                          borderSide: BorderSide.none
                        )
                      ),
                    )
              ],
            ),
          ),
        ),
        ),
    );

    // return Scaffold(
    //   appBar: AppBar(title: Text('Weather Forecast')),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       children: [
    //         TextField(
    //           controller: _cityController,
    //           decoration: InputDecoration(
    //             labelText: 'Enter city name',
    //             border: OutlineInputBorder(),
    //             suffixIcon: IconButton(
    //               icon: Icon(Icons.search),
    //               onPressed: () {
    //                 weatherProvider.fetchWeather(_cityController.text);
    //               },
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: 20),
    //         if (weatherProvider.isLoading)
    //           CircularProgressIndicator()
    //         else if (weatherProvider.weather != null)
    //           Column(
    //             children: [
    //               Text(
    //                 weatherProvider.weather!.cityName,
    //                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    //               ),
    //               SizedBox(height: 10),
    //               Image.network(
    //                 'https://openweathermap.org/img/wn/${weatherProvider.weather!.iconCode}@2x.png',
    //               ),
    //               Text(
    //                 '${weatherProvider.weather!.temperature.toStringAsFixed(1)} °C',
    //                 style: TextStyle(fontSize: 24),
    //               ),
    //               Text(
    //                 weatherProvider.weather!.description,
    //                 style: TextStyle(fontSize: 18),
    //               ),
    //             ],
    //           ),
    //      ],
    //    ),
//       )
//     )
   }
 }
