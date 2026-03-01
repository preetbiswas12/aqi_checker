// ✅ Maps Service - Supports both Google Maps (PAID) and OpenStreetMap (FREE)
// Switch between them using Secrets.useGoogleMaps flag
//
// FREE: OpenStreetMap + Flutter Map (no API key needed!)
// PAID: Google Maps (requires API key, ~$7 per 1000 requests)

import 'package:flutter/material.dart';

enum MapProvider { openStreetMap, googleMaps }

class MapsConfig {
  /// Returns which map provider to use
  /// Set Secrets.useGoogleMaps = false for FREE OpenStreetMap
  /// Set Secrets.useGoogleMaps = true for PAID Google Maps
  static MapProvider getProvider({bool? overrideUseGoogleMaps}) {
    final useGoogleMaps =
        overrideUseGoogleMaps ?? (false); // DEFAULT: Use free OpenStreetMap

    return useGoogleMaps
        ? MapProvider.googleMaps
        : MapProvider.openStreetMap;
  }

  /// Get map usage cost per month estimate
  static String getCostEstimate(MapProvider provider) {
    switch (provider) {
      case MapProvider.openStreetMap:
        return '\$0/month (FREE)';
      case MapProvider.googleMaps:
        return '\$50-500+/month (depends on usage)';
    }
  }

  /// Get map provider name
  static String getProviderName(MapProvider provider) {
    switch (provider) {
      case MapProvider.openStreetMap:
        return 'OpenStreetMap + Flutter Map';
      case MapProvider.googleMaps:
        return 'Google Maps';
    }
  }

  /// Check if current provider is free
  static bool isFree(MapProvider provider) {
    return provider == MapProvider.openStreetMap;
  }
}

/// Example usage in your MapScreen:
///
/// import 'package:flutter_map/flutter_map.dart';
/// import 'package:latlong2/latlong.dart';
///
/// // For FREE OpenStreetMap:
/// FlutterMap(
///   options: MapOptions(
///     center: LatLng(28.3639, 77.5360),
///     zoom: 13.0,
///   ),
///   children: [
///     TileLayer(
///       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
///       userAgentPackageIdentifier: 'com.aeroguard.app',
///     ),
///     MarkerLayer(markers: _markers),
///     PolylineLayer(polylines: _polylines),
///   ],
/// )
///
/// // For PAID Google Maps:
/// GoogleMap(
///   initialCameraPosition: CameraPosition(
///     target: LatLng(28.3639, 77.5360),
///     zoom: 13.0,
///   ),
///   markers: _markers,
///   polylines: _polylines,
///   tileOverlays: _tileOverlays,
/// )
