import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonorMapScreen extends StatefulWidget {
  const DonorMapScreen({super.key});

  @override
  State<DonorMapScreen> createState() => _DonorMapScreenState();
}

class _DonorMapScreenState extends State<DonorMapScreen> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = const LatLng(24.8607, 67.0011); // Example: Karachi, PK

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: const Text('Donor Map', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 12),
        onMapCreated: (controller) => mapController = controller,
        myLocationEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId('sampleUser'),
            position: _initialPosition,
            infoWindow: const InfoWindow(title: 'Sample User Location'),
          ),
        },
      ),
    );
  }
}
