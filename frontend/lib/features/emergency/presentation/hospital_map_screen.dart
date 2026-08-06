import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/theme/neuro_colors.dart';
import '../../../../core/theme/neuro_typography.dart';

class HospitalMapScreen extends StatefulWidget {
  const HospitalMapScreen({super.key});

  @override
  State<HospitalMapScreen> createState() => _HospitalMapScreenState();
}

class _HospitalMapScreenState extends State<HospitalMapScreen> {
  // Mock coordinate for user (e.g., Cairo, Egypt)
  final LatLng _userLocation = const LatLng(30.0444, 31.2357);
  
  // Mock hospitals with stroke/neuro capability
  final List<Marker> _hospitalMarkers = [
    Marker(
      point: const LatLng(30.0500, 31.2400),
      width: 80,
      height: 80,
      child: const Icon(Icons.local_hospital, color: NeuroColors.emergency, size: 40),
    ),
    Marker(
      point: const LatLng(30.0400, 31.2300),
      width: 80,
      height: 80,
      child: const Icon(Icons.local_hospital, color: NeuroColors.primary, size: 40),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Navigation', style: NeuroTypography.textTheme.headlineLarge),
        backgroundColor: NeuroColors.background,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _userLocation,
              initialZoom: 14.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.neurobleed.enterprise',
              ),
              MarkerLayer(
                markers: [
                  // User Location Marker
                  Marker(
                    point: _userLocation,
                    width: 80,
                    height: 80,
                    child: const Icon(Icons.my_location, color: Colors.blueAccent, size: 30),
                  ),
                  ..._hospitalMarkers,
                ],
              ),
            ],
          ),
          
          // SOS Overlay Bottom Sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: NeuroColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_rounded, color: NeuroColors.emergency, size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Nearest Neuro Center: 3 mins (1.2 km)',
                          style: NeuroTypography.textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Trigger actual routing / OSRM / Ambulance call
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: NeuroColors.emergency,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('DISPATCH AMBULANCE (SOS)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
