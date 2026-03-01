// Available Air Quality APIs:
// 1. OpenWeatherMap (FREE) - 1,000 calls/day - RECOMMENDED
// 2. WaqI (PAID) - Limited free tier
//
// Switch using Secrets.useWaqiApi flag in lib/secrets.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../secrets.dart';
import 'openweather_service.dart';

class WaqiService {
  static const String baseUrl = 'https://api.waqi.info/feed';
  final OpenWeatherService _openWeatherService = OpenWeatherService();

  /// Fetch AQI for the given latitude/longitude
  /// Automatically uses OpenWeatherMap (FREE) or WaqI based on Secrets.useWaqiApi
  Future<Map<String, dynamic>> getAirQuality(double lat, double lng) async {
    // Use OpenWeatherMap by default (FREE & more reliable)
    if (!Secrets.useWaqiApi) {
      return _openWeatherService.getAirQuality(lat, lng);
    }

    // Fallback to WaqI (PAID)
    return _getWaqiAirQuality(lat, lng);
  }

  /// Original WaqI implementation (PAID)
  Future<Map<String, dynamic>> _getWaqiAirQuality(
    double lat,
    double lng,
  ) async {
    final String url = '$baseUrl/geo:$lat;$lng/?token=${Secrets.waqiApiKey}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'ok') {
          return {
            'aqi': data['data']['aqi'], // numeric AQI (0-500)
            'city': data['data']['city']['name'], // station name
            'dominentpol': data['data']['dominentpol'], // e.g. "pm25"
            'timestamp': data['data']['time']['s'], // last update
            'provider': 'WaqI',
          };
        }
      }
      throw Exception('Failed to load air quality data');
    } catch (e) {
      print("WaqI Error: $e");
      // Fallback to OpenWeatherMap if WaqI fails
      print("Falling back to OpenWeatherMap...");
      return _openWeatherService.getAirQuality(lat, lng);
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
