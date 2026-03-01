// Copy this file to secrets.dart and fill in your API keys
// Get FREE API keys from:
// - Gemini: https://aistudio.google.com
// - OpenWeatherMap: https://openweathermap.org/api
// - Google Maps (optional): https://console.cloud.google.com

class Secrets {
  // ✅ FREE: Google Gemini AI from Google AI Studio
  // Get it: https://aistudio.google.com -> Click "Get API Key"
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_FROM_AI_STUDIO';

  // ✅ FREE: OpenWeatherMap (1,000 calls/day)
  // Get it: https://openweathermap.org/api -> Sign up -> Copy API Key
  static const String openWeatherApiKey = 'YOUR_OPENWEATHER_API_KEY';

  // 🟡 PAID Alternative: WaqI Air Quality API
  // Get it: https://waqi.info/api -> Request API Key
  static const String waqiApiKey = 'YOUR_WAQI_API_KEY';

  // 💰 PAID Alternative: Google Maps API
  // Get it: https://console.cloud.google.com -> Enable Maps SDK
  // Set to null to use FREE OpenStreetMap instead
  static const String? googleMapsApiKey = null;

  // 🟡 FREE Alternative: IQAir API (50 calls/day)
  // Get it: https://www.iqair.com/air-quality-api
  static const String iqairApiKey = 'YOUR_IQAIR_API_KEY';

  // Configuration flags
  // Set to true to use paid Google Maps, false for free OpenStreetMap
  static const bool useGoogleMaps = false;
  // Set to true to use WaqI, false for free OpenWeatherMap
  static const bool useWaqiApi = false;
}
