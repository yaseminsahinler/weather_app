import 'package:intl/intl.dart';

class ForecastDayModel {
  final String date;
  final double maxTempC;
  final String iconUrl;

  ForecastDayModel({
    required this.date,
    required this.maxTempC,
    required this.iconUrl,
  });
  String get formattedDate {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('EEEE, d MMM', 'tr_TR').format(parsedDate);
    } catch (e) {
      return date; // Dönüştürme hatası olursa orijinal tarihi döner
    }
  }

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayModel(
      date: json['date'],
      maxTempC: (json['day']['maxtemp_c'] as num).toDouble(),
      iconUrl: 'https:${json['day']['condition']['icon']}',
    );
  }
}

class WeatherModel {
  final String cityName;
  final double tempC;
  final String conditionText;
  final double uv;
  final int humidity;
  final double precipMm;
  final List<ForecastDayModel> forecastDays; // 👈 Gelecek günler listesi

  WeatherModel({
    required this.cityName,
    required this.tempC,
    required this.conditionText,
    required this.uv,
    required this.humidity,
    required this.precipMm,
    required this.forecastDays,
  });

  // UV Değerine Göre Metin Dönen Yardımcı Metot
  String get uvRiskLevel {
    if (uv <= 2) return 'Low';
    if (uv <= 5) return 'Moderate';
    if (uv <= 7) return 'High';
    if (uv <= 10) return 'Very High';
    return 'Extreme';
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    var forecastList = (json['forecast']['forecastday'] as List)
        .map((e) => ForecastDayModel.fromJson(e))
        .toList();

    return WeatherModel(
      cityName: json['location']['name'],
      tempC: (json['current']['temp_c'] as num).toDouble(),
      conditionText: json['current']['condition']['text'],
      uv: (json['current']['uv'] as num).toDouble(),
      humidity: json['current']['humidity'],
      precipMm: (json['current']['precip_mm'] as num).toDouble(),
      forecastDays: forecastList,
    );
  }
}
