import 'package:flutter/material.dart';

import '../models/weather_model.dart';

class Bar1 extends StatelessWidget {
  final WeatherModel weatherData;

  const Bar1({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                weatherData.cityName,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weatherData.tempC.round()}',
                    style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      height: 0.9,
                    ),
                  ),
                  const Text(
                    '°',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
              Text(
                weatherData.conditionText,
                style: const TextStyle(fontSize: 20, height: 2.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
