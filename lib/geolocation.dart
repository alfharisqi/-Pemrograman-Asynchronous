import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Future<Position>? position; // Declare the variable to hold the Position

  // Modified getPosition method to simulate a delay
  Future<Position> getPosition() async {
    await Geolocator.isLocationServiceEnabled(); // Check if location services are enabled
    await Future.delayed(const Duration(seconds: 3)); // Simulate a 3-second delay
    Position position = await Geolocator.getCurrentPosition(); // Get the current position
    return position;
  }

  @override
  void initState() {
    super.initState();
    position = getPosition(); // Set the position to the result of getPosition
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Location')),
      body: Center(
        child: FutureBuilder<Position>(
          future: position, // Use the 'position' variable to get the Future<Position>
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading spinner while waiting
            } else if (snapshot.connectionState == ConnectionState.done) {
              // Handle completed state
              if (snapshot.hasError) {
                return const Text('Something terrible happened!'); // Show error message if there's an error
              }
              if (snapshot.hasData) {
                Position? myPos = snapshot.data;
                return Text(
                  'Latitude: ${myPos!.latitude} - Longitude: ${myPos.longitude}',
                  style: const TextStyle(fontSize: 18),
                );
              } else {
                return const Text('No location data available');
              }
            } else {
              return const Text('Something went wrong'); // Handle other states
            }
          },
        ),
      ),
    );
  }


}
