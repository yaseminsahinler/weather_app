import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather_app/services/location_service.dart';

import '../models/weather_model.dart';

class WeatherService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.weatherapi.com/v1/'));
  final LocationService _locationService = LocationService();

  Future<WeatherModel?> fetchCurrentWeather(String city) async {
    try {
      final response = await _dio.get(
        'forecast.json',
        queryParameters: {
          // Key'i güvenli şekilde .env dosyasından çekiyoruz
          'key': dotenv.env['WEATHER_API_KEY'] ?? '',
          'q': city,
          'days': 7,
          'lang': 'tr', // Türkçe hava durumu açıklaması için
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint('API İstek Hatası: $e');
    }
    return null;
  }

  Future<WeatherModel?> fetchWeatherByLocation() async {
    try {
      Position position = await _locationService.getCurrentLocation();
      final response = await _dio.get(
        'forecast.json',
        queryParameters: {
          'key': dotenv.env['WEATHER_API_KEY'] ?? '',
          'q': '${position.latitude},${position.longitude}',
          'days': 7,
          'lang': 'tr',
        },
      );
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint('Konum Bazlı API İstek Hatası: $e');
    }
    return null;
  }
}
