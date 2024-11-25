import 'package:flutter/material.dart';

class NavigationDialogScreen extends StatefulWidget {
  const NavigationDialogScreen({super.key});

  @override
  State<NavigationDialogScreen> createState() => _NavigationDialogScreenState();
}

class _NavigationDialogScreenState extends State<NavigationDialogScreen> {
  Color color = Colors.blue.shade700; // Default color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation Dialog Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Change Color'),
          onPressed: () {
            _showColorDialog(context); // Show color dialog when button is pressed
          },
        ),
      ),
    );
  }

  // Function to show the dialog
  _showColorDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: false, // User cannot dismiss the dialog by tapping outside
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Very important question'),
          content: const Text('Please choose a color'),
          actions: <Widget>[
            // Red button
            TextButton(
              child: const Text('Red'),
              onPressed: () {
                setState(() {
                  color = Colors.red.shade700; // Change color to red
                });
                Navigator.pop(context); // Close the dialog
              },
            ),
            // Green button
            TextButton(
              child: const Text('Green'),
              onPressed: () {
                setState(() {
                  color = Colors.green.shade700; // Change color to green
                });
                Navigator.pop(context); // Close the dialog
              },
            ),
            // Blue button
            TextButton(
              child: const Text('Blue'),
              onPressed: () {
                setState(() {
                  color = Colors.blue.shade700; // Change color to blue
                });
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}