import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/weather_model.dart';
import '../services/weather_services.dart';

import '../bolumler/up_bar.dart';
import '../bolumler/bar_1.dart';
import '../bolumler/bar_2.dart';
import '../bolumler/bar_3.dart';

class HavaDurumuSayfasi extends StatefulWidget {
  const HavaDurumuSayfasi({super.key});

  @override
  State<HavaDurumuSayfasi> createState() => _HavaDurumuSayfasiState();
}

class _HavaDurumuSayfasiState extends State<HavaDurumuSayfasi> {
  // 1. SERVİS VE DEĞİŞKEN TANIMLARI
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weatherData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather('Istanbul');
  }

  // API'den veri çeken fonksiyon
  Future<void> _fetchWeather(String city) async {
    final data = await _weatherService.fetchCurrentWeather(city);
    setState(() {
      _weatherData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC9D5E5),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/weatherbackground.svg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Container(color: Colors.black.withValues(alpha: 0.0)),
            ),
          ),
          SafeArea(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _weatherData == null
                ? const Center(child: Text('Veri alınamadı'))
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        UpBar(cityName: _weatherData!.cityName),
                        Bar1(weatherData: _weatherData!),
                        Bar2(weatherData: _weatherData!),
                        Bar3(weatherData: _weatherData!),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
