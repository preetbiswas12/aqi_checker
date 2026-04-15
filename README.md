# AQI Checker

A real-time air quality monitoring application that provides AQI (Air Quality Index) information and recommendations using AI-powered insights.

## Features

- **Real-time Air Quality Monitoring**: Get current AQI data for your location
- **AI-Powered Recommendations**: Receive intelligent health and lifestyle recommendations based on air quality
- **Interactive Maps**: View air quality data on an interactive Google Map
- **Trip Planning**: Plan trips with consideration for air quality along different routes
- **Firebase Integration**: Cloud-backed data storage and synchronization
- **Multi-Platform Support**: Available on Android, iOS, Windows, macOS, Linux, and Web

## Technology Stack

- **Framework**: Flutter 3.10+
- **Language**: Dart
- **Backend Services**:
  - Firebase (Firestore, Authentication)
  - Google Maps API
  - WAQI (World Air Quality Index) API
  - Google Gemini AI
- **Key Packages**:
  - google_maps_flutter
  - firebase_core
  - cloud_firestore
  - geolocator
  - permission_handler

## Getting Started

### Prerequisites

- Flutter SDK 3.10 or higher
- Dart 3.10 or higher
- A Google Maps API key
- Firebase project setup
- WAQI API key
- Google Gemini API key

### Installation

1. Clone the repository:
```bash
git clone https://github.com/preetbiswas12/aqi_checker.git
cd aqi_checker
```

2. Create a `lib/secrets.dart` file with your API keys:
```dart
class Secrets {
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_KEY';
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY';
  static const String waqiApiKey = 'YOUR_WAQI_API_KEY';
}
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the application:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── secrets.dart           # API keys (not in version control)
└── services/
    ├── waqi_service.dart      # Air quality data fetching
    ├── gemini_service.dart    # AI-powered recommendations
    └── directions_service.dart # Route planning
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Author

**Preet Biswas** - [GitHub](https://github.com/preetbiswas12)

## License

This project is licensed under the MIT License.

## Support

For more information about Flutter development, visit the
[official documentation](https://docs.flutter.dev/).
