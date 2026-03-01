# AeroGuard Agent

**Real-Time Air Quality Monitoring & Smart Navigation Assistant**

AeroGuard Agent is an intelligent Flutter mobile application that monitors air quality in real-time and provides smart route planning to help users navigate while avoiding areas with poor air quality. Powered by AI-driven recommendations and community hazard reporting, it ensures healthier travel for everyone.

---

## 📋 Product Overview

**Product Name:** AeroGuard Agent  
**Platform:** iOS, Android, Web, macOS, Linux, Windows  
**Technology Stack:** Flutter, Dart, Firebase, Google Gemini AI, OpenStreetMap/Google Maps  
**Current Version:** 1.0.0  
**Cost Model:** 100% Free or Minimal Cost (see [Cost & API Breakdown](#-cost--api-breakdown))  

---

## ✨ Key Features

### 1. **Real-Time Air Quality Monitoring**
- Live AQI (Air Quality Index) tracking using the WaqI API
- Location-based air quality data with station information
- Displays dominant pollutant types (PM2.5, PM10, O3, NO2, etc.)
- Automatic updates as user moves

### 2. **AI-Powered Intelligent Agent**
- **Gemini AI Integration**: Conversational AI assistant that:
  - Analyzes current air quality conditions
  - Provides health recommendations based on AQI
  - Answers user queries about air quality
  - Processes natural language commands

### 3. **Smart Route Planning**
- Multi-route path calculation to users' destinations
- Air-quality-aware routing that avoids high-pollution areas
- Real-time route optimization
- Polyline visualization on Google Maps
- Source and destination AQI comparison

### 4. **Interactive Maps** (Google Maps OR OpenStreetMap)
- Real-time user location tracking with GPS
- Hazard markers showing reported air quality issues
- Custom heatmap overlay showing pollution hotspots
- Multi-marker support for different hazard types
- Zoom and pan controls with smooth animations
- **Choose:** Google Maps (paid) or OpenStreetMap (free)

### 5. **Community Hazard Reporting**
- Users can report air quality hazards with:
  - Location coordinates
  - Hazard type classification
  - Text descriptions
  - Photo attachments/evidence
- Real-time hazard verification system
- Community-driven hazard validation
- Persistent storage in Firebase Firestore

### 6. **Gamification & Rewards**
- User points system for verified hazard reports
- Points tracking and persistence via SharedPreferences
- Incentivizes community participation
- Leaderboard-ready architecture

### 7. **Image-Based Hazard Documentation**
- Camera integration using ImagePicker
- Multi-image support for hazard evidence
- Image caching via Flutter Cache Manager
- Local image processing capabilities

### 8. **Persistent User Data**
- SharedPreferences for local user points
- Firebase Firestore for cloud-based hazard database
- Real-time sync across devices
- Offline capability with data persistence

### 9. **Multi-Platform Support**
- Native Android support with Google Play Services
- Native iOS support with AppKit integration
- Web version with responsive design
- Linux, macOS, and Windows desktop support

---

## 🏗️ Architecture

### Core Services

**WaqiService** (`lib/services/waqi_service.dart`)
- Fetches real-time AQI data from WaqI API
- Geo-location based queries
- Returns AQI, city name, dominant pollutant, and timestamp

**GeminiService** (`lib/services/gemini_service.dart`)
- Integrates Google Generative AI (Gemini)
- Function calling for:
  - `get_current_air_quality()` - Fetches current AQI
  - `plan_trip_to_destination()` - Calculates optimal routes
- Conversational chat-based interface
- Multi-turn conversation support

**DirectionsService** (`lib/services/directions_service.dart`)
- Google Maps Directions API integration
- Multi-route calculation
- Polyline point extraction
- Route distance and duration calculation

### Main Components

**MapScreen** (`lib/main.dart`)
- Primary UI widget containing:
  - Google Maps with custom markers and overlays
  - Real-time location tracking
  - Bottom sheet with AI agent conversation
  - Hazard reporting dialog
  - Route visualization
  - AQI display cards

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.10.4)
- Google Generative AI (Gemini) API Key from [Google AI Studio](https://aistudio.google.com) (FREE)
- Firebase project setup (FREE Spark plan)
- Air Quality API Key (Choose one):
  - **FREE:** OpenWeatherMap (1,000 calls/day)
  - **Alternative FREE:** IQAir (50 calls/day)
  - **Paid:** WaqI API
- Maps (Choose one):
  - **FREE:** OpenStreetMap/Flutter Map (no key needed)
  - **Paid:** Google Maps API Key

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd aeroguard_agent
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Get Free API Keys**

   **A) Google Gemini AI (FREE)**
   - Go to [Google AI Studio](https://aistudio.google.com)
   - Click "Get API Key"
   - Copy your free API key

   **B) OpenWeatherMap (FREE) - For Air Quality**
   - Visit [openweathermap.org](https://openweathermap.org/api)
   - Sign up for free account
   - Create API key (1,000 calls/day free)

   **C) Alternative: IQAir (FREE)**
   - Visit [iqair.com/api](https://www.iqair.com/air-quality-api)
   - Get free tier API key (50 calls/day)

4. **Configure API Keys**
   - Create `lib/secrets.dart`:
   ```dart
   class Secrets {
     // FREE: Google Gemini AI
     static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_FROM_AI_STUDIO';
     
     // Choose ONE air quality API:
     // FREE Option 1: OpenWeatherMap
     static const String openWeatherApiKey = 'YOUR_OPENWEATHER_API_KEY';
     
     // FREE Option 2: IQAir
     static const String iqairApiKey = 'YOUR_IQAIR_API_KEY';
     
     // PAID Option: WaqI
     static const String waqiApiKey = 'YOUR_WAQI_API_KEY';
     
     // OPTIONAL: Google Maps (Paid - use OpenStreetMap for FREE)
     static const String? googleMapsApiKey = null; // Set to null to use OpenStreetMap
   }
   ```

5. **Setup Firebase (FREE Spark Plan)**
   - Go to [Firebase Console](https://console.firebase.google.com)
   - Create new project
   - Add `google-services.json` (Android) to `android/app/`
   - Configure iOS Firebase settings
   - Create Firestore database in test mode
   - Create Storage bucket for images

6. **Choose Map Provider in main.dart**
   
   **For FREE OpenStreetMap:**
   - Use `FlutterMap` widget instead of `GoogleMap`
   - No API key required
   
   **For Paid Google Maps:**
   - Enable Maps SDK
   - Add API key to AndroidManifest.xml and Info.plist

7. **Run the app**
   ```bash
   flutter run
   ```

---

## 📦 Dependencies

### Core
- `flutter` - UI Framework
- `firebase_core` (^2.24.2) - Firebase initialization
- `cloud_firestore` (^4.14.0) - Cloud database

### Maps & Location
**Option 1: Google Maps (Paid)**
- `google_maps_flutter` (^2.14.0) - Google Maps integration
- `flutter_polyline_points` (^3.1.0) - Route polyline handling

**Option 2: OpenStreetMap (FREE)**
- `flutter_map` (^6.0.0) - Free, open-source maps
- `latlong2` (^0.9.0) - Lat/Long coordinates

**Location Services (Both)**
- `geolocator` (^14.0.2) - GPS location tracking

### AI & APIs
- `google_generative_ai` (^0.4.7) - Gemini AI integration (FREE tier available)
- `http` (^1.6.0) - HTTP requests

### UI & Data
- `flutter_markdown` (^0.7.7+1) - Markdown rendering for AI responses
- `shared_preferences` (^2.5.4) - Local data persistence
- `permission_handler` (^12.0.1) - Platform permissions
- `image_picker` (^1.0.7) - Camera/gallery image selection
- `flutter_cache_manager` (^3.3.1) - Image caching

---

## 🎯 Use Cases

1. **Daily Commuters**
   - Check air quality before leaving home
   - Get safe routes avoiding pollution hotspots
   - Receive health recommendations

2. **Health-Conscious Users**
   - Monitor personal air quality exposure
   - Track pollution levels over time
   - Report hazardous areas

3. **Community Contributors**
   - Report air quality issues with evidence
   - Earn points for verified reports
   - Help improve air quality awareness

4. **Delivery & Logistics**
   - Optimize routes based on air quality
   - Minimize exposure to harmful pollutants
   - Plan efficient deliveries

---

## 🔐 Firebase Integration

**Firestore Collections:**
- `hazards` - Community-reported air quality issues
  - Fields: `id`, `lat`, `lng`, `type`, `description`, `timestamp`, `imageUrl`, `verified`

**Real-Time Features:**
- Live hazard updates across all users
- Instant verification workflow
- Cloud backup for user data

---

## 🎮 Gamification System

- **Points System:**
  - +10 points for verified hazard reports
  - Points stored in local preferences and cloud
  - Encourages community participation

---

## 📱 UI/UX Features

- **Material Design 3** with Teal color scheme
- **Bottom Sheet**: AI agent interface with chat history
- **Alert Dialogs**: Hazard verification and reporting
- **Cards**: AQI display with color-coded severity
- **Heatmap Overlay**: Visual pollution hotspot representation
- Responsive design for all screen sizes

---

## 🔄 Data Flow

```
User Location (GPS)
    ↓
WaqiService (Real-time AQI)
    ↓
GeminiService (AI Analysis)
    ↓
DirectionsService (Smart Routes)
    ↓
Google Maps (Visualization)
    ↓
Firebase Firestore (Cloud Persistence)
    ↓
SharedPreferences (Local Cache)
```

---

## 🛠️ Development

### Project Structure
```
lib/
├── main.dart              # Main app & MapScreen
├── secrets.dart           # API keys configuration
└── services/
    ├── waqi_service.dart      # Air quality API
    ├── gemini_service.dart    # AI agent service
    └── directions_service.dart # Route planning
```

### Running Tests
```bash
flutter test
```

### Building for Production
```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web
```

---

## 🌍 Supported Platforms

- ✅ Android (Primary)
- ✅ iOS (Primary)
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

---

## 🔗 API Integrations

### Recommended FREE Stack ⭐
1. **Google Generative AI (Gemini)** - Conversational AI (FREE tier from AI Studio)
2. **OpenWeatherMap** - Air Quality API (1,000 calls/day FREE)
3. **OpenStreetMap + Flutter Map** - Maps (Completely FREE, no key needed)
4. **Firebase Firestore** - Cloud database (FREE Spark plan: 1GB, 50k reads/day)
5. **Firebase Storage** - Image hosting (FREE tier: 5GB/month)

### Alternative Paid Options
1. **WaqI Air Quality API** - Real-time AQI data (Limited free, then paid)
2. **Google Maps API** - Maps and directions (Paid: $7 per 1000 requests)
3. **IQAir** - Air quality (FREE 50 calls/day, then paid)
4. **Mapbox** - Maps (FREE 50k loads/month, then paid)

---

## ⚙️ Configuration & Customization

### Heatmap Toggle
- Set `enableHeatmap = true/false` in `_MapScreenState`

### Routing Toggle
- Set `enableRouting = true/false` in `_MapScreenState`

### Initial Map Position
- Update `_initialPosition` to your default location

---

## � Cost & API Breakdown

### FREE Stack (Recommended)
| Service | Cost | Limit | Better For |
|---------|------|-------|------------|
| **Google Gemini AI** | $0 | Free tier quota | MVP & hackathons |
| **Firebase Firestore** | $0 | 1GB, 50k reads/day | Small-to-medium apps |
| **Firebase Storage** | $0 | 5GB/month | MVP image storage |
| **OpenWeatherMap** | $0 | 1,000 calls/day | Air quality monitoring |
| **OpenStreetMap** | $0 | Unlimited | Map display |
| **Flutter** | $0 | Unlimited | App development |
| **---** | **$0/month** | **Unlimited users** | **Until scale** |

### PAID Stack (Advanced)
| Service | Cost | Limit | Better For |
|---------|------|-------|------------|
| **Google Maps** | $7/1000 | Unlimited | Production mapping |
| **WaqI** | $99+/month | Higher limits | Enterprise AQI |
| **Firebase Blaze** | Pay-per-use | Unlimited | Scaling app |
| **Google Cloud Storage** | $0.02/GB | Unlimited | High-volume images |

### Free to Paid Migration Path
```
✅ Start: 100% FREE (OpenWeatherMap + OpenStreetMap)
  ↓
💰 Scale: Add Google Maps when needed (~$50/month)
  ↓
📈 Grow: Upgrade Firebase & WaqI (~$150/month)
  ↓
🚀 Enterprise: Full paid stack with optimizations
```

## 🐛 Known Limitations

### FREE Stack Limitations
- OpenWeatherMap: 1,000 API calls/day (1 per min for 16 users)
- Firebase Firestore: 50k reads/day (handles ~2000 users checking once)
- Firebase Storage: 5GB/month (5000 hazard photos)
- OpenStreetMap: Uses community tiles (slower than Google Maps)

### Paid Stack Limitations
- Google Maps API: Quota constraints per billing account
- WaqI API: Rate limiting for frequent requests
- Firebase Blaze: Cost increases with scale

**For hackathons & MVP: FREE stack is perfect!** 🎉

---

## � Free API Service Implementations

### OpenWeatherMap Service (Free Alternative to WaqI)
```dart
// lib/services/openweather_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenWeatherService {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/air_pollution';
  static const String apiKey = 'YOUR_OPENWEATHER_API_KEY';

  Future<Map<String, dynamic>> getAirQuality(double lat, double lng) async {
    final String url = '$baseUrl?lat=$lat&lon=$lng&appid=$apiKey';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final aqi = data['list'][0]['main']['aqi']; // 1-5 scale
        
        return {
          'aqi': aqi * 50, // Convert to 0-250 scale (WaqI compatible)
          'city': 'Location',
          'dominentpol': _getPollutant(data['list'][0]['components']),
          'timestamp': DateTime.now().toString(),
        };
      }
      throw Exception('Failed to load air quality');
    } catch (e) {
      return {'aqi': -1, 'error': e.toString()};
    }
  }
  
  String _getPollutant(Map<String, dynamic> components) {
    if (components['pm25'] > 35) return 'pm25';
    if (components['pm10'] > 50) return 'pm10';
    if (components['o3'] > 100) return 'o3';
    return 'no2';
  }
}
```

### OpenStreetMap Implementation (Free Maps)
```dart
// Replace GoogleMap widget with:
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

FlutterMap(
  options: MapOptions(
    center: LatLng(28.3639, 77.5360),
    zoom: 13.0,
  ),
  children: [
    TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageIdentifier: 'com.aeroguard.app',
    ),
    MarkerLayer(markers: _markers),
    PolylineLayer(polylines: _polylines),
  ],
)
```

## 📈 Future Enhancements

- [ ] Advanced health analytics dashboard
- [ ] Machine learning-based pollution prediction
- [ ] Multi-language support
- [ ] Voice command integration
- [ ] Social features and community leaderboards
- [ ] Wearable device integration
- [ ] Push notifications for air quality alerts
- [ ] Offline route caching
- [ ] AR visualization of pollution levels
- [ ] Switch between OpenStreetMap and Google Maps (toggle)
- [ ] Support for multiple air quality API providers

---

## 📄 License

This project is part of the TechSprint Hackathon 2026.

---

## 🤝 Support & Contribution

For issues, feature requests, or contributions, please contact the development team.

**Made with ❤️ for cleaner air**
