import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = ''; // Start with an empty string

  @override
  void initState() {
    super.initState();
    getPosition(); // Fetch location when the screen is initialized
  }

  Future<void> getPosition() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        myPosition = 'Location services are disabled. Please enable them in your settings.';
      });
      return;
    }

    // Request location permission
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      setState(() {
        myPosition = 'Location permissions are denied. Please grant permission.';
      });
      return;
    } else if (permission == LocationPermission.deniedForever) {
      setState(() {
        myPosition = 'Location permissions are permanently denied. Please enable them in your settings.';
      });
      return;
    }

    // If permission is granted, get the current position
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        myPosition =
        'Latitude: ${position.latitude.toString()} - Longitude: ${position.longitude.toString()}';
      });
    } catch (e) {
      setState(() {
        myPosition = 'Failed to get location: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator if myPosition is empty, else show the location
    final myWidget = myPosition.isEmpty
        ? const CircularProgressIndicator() // Show loading while fetching
        : Text(myPosition); // Show location once it's fetched

    return Scaffold(
      appBar: AppBar(title: const Text('Current Location')),
      body: Center(child: myWidget), // Display the widget
    );
  }
}
