// ✅ FREE Air Quality API - OpenWeatherMap
// 1,000 calls/day free tier (enough for small-to-medium apps)
// Get API key: https://openweathermap.org/api

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../secrets.dart';

class OpenWeatherService {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/air_pollution';

  /// Fetch AQI using OpenWeatherMap Air Pollution API
  /// Returns a map compatible with WaqiService format for easy switching
  Future<Map<String, dynamic>> getAirQuality(double lat, double lng) async {
    final String url = '$baseUrl?lat=$lat&lon=$lng&appid=${Secrets.openWeatherApiKey}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['list'] != null && (data['list'] as List).isNotEmpty) {
          final pollutionData = data['list'][0];
          final mainAqi = pollutionData['main']['aqi']; // 1-5 scale
          final components = pollutionData['components'];

          // Convert AQI scale: OpenWeather (1-5) -> WaqI compatible (0-500)
          // 1 = Good (0-50), 2 = Fair (51-100), 3 = Moderate (101-150),
          // 4 = Poor (151-200), 5 = Very Poor (201-300)
          final aqiValue = _convertAqiScale(mainAqi);

          return {
            'aqi': aqiValue,
            'city': 'Location',
            'dominentpol': _getDominantPollutant(components),
            'timestamp': DateTime.now().toIso8601String(),
            'provider': 'OpenWeatherMap',
            'raw_aqi_level': mainAqi, // 1-5
            'components': components,
          };
        }
      }
      throw Exception('Failed to load air quality data');
    } catch (e) {
      print("OpenWeather Error: $e");
      return {'aqi': -1, 'error': e.toString(), 'provider': 'OpenWeatherMap'};
    }
  }

  /// Determine dominant pollutant from components
  String _getDominantPollutant(Map<String, dynamic> components) {
    final pm25 = (components['pm2_5'] ?? 0).toDouble();
    final pm10 = (components['pm10'] ?? 0).toDouble();
    final o3 = (components['o3'] ?? 0).toDouble();
    final no2 = (components['no2'] ?? 0).toDouble();
    final so2 = (components['so2'] ?? 0).toDouble();
    final co = (components['co'] ?? 0).toDouble();

    // WHO guidelines thresholds
    if (pm25 > 35) return 'pm25';
    if (pm10 > 50) return 'pm10';
    if (o3 > 100) return 'o3';
    if (no2 > 40) return 'no2';
    if (so2 > 20) return 'so2';
    if (co > 1000) return 'co';

    return 'general'; // All pollutants within acceptable levels
  }

  /// Convert OpenWeatherMap AQI (1-5) to WaqI-compatible scale (0-500)
  /// OpenWeatherMap scale:
  /// 1 = Good
  /// 2 = Fair
  /// 3 = Moderate
  /// 4 = Poor
  /// 5 = Very Poor
  int _convertAqiScale(int owmAqi) {
    switch (owmAqi) {
      case 1:
        return 25; // Good (0-50)
      case 2:
        return 75; // Fair (51-100)
      case 3:
        return 125; // Moderate (101-150)
      case 4:
        return 175; // Poor (151-200)
      case 5:
        return 250; // Very Poor (201-300+)
      default:
        return 0;
    }
  }

  /// Get health recommendation based on AQI
  String getHealthRecommendation(int aqi) {
    if (aqi <= 50) {
      return '✅ Air quality is Good. You can go outside safely!';
    } else if (aqi <= 100) {
      return '🟡 Air quality is Fair. Sensitive groups should limit outdoor activities.';
    } else if (aqi <= 150) {
      return '🟠 Air quality is Moderate. Consider wearing a mask if going out.';
    } else if (aqi <= 200) {
      return '🔴 Air quality is Poor. Everyone should limit outdoor activities.';
    } else {
      return '⛔ Air quality is Very Poor. Avoid outdoor activities!';
    }
  }
}
