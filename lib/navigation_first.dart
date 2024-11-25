import 'package:flutter/material.dart';

class NavigationFirst extends StatefulWidget {
  const NavigationFirst({super.key});

  @override
  State<NavigationFirst> createState() => _NavigationFirstState();
}

class _NavigationFirstState extends State<NavigationFirst> {
  Color color = Colors.blue.shade700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Change Color"),
          onPressed: () {
            _navigateAndGetColor(context);
          },
        ),
      ),
    );
  }

  // Updated method
  Future _navigateAndGetColor(BuildContext context) async {
    color = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NavigationSecond(),
      ),
    ) ?? Colors.blue;

    setState(() {});
  }
}

// Second screen to pick a color
class NavigationSecond extends StatelessWidget {
  const NavigationSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Pick a Red Color"),
              onPressed: () {
                // Send back a red color when button is pressed
                Navigator.pop(context, Colors.red);
              },
            ),
            ElevatedButton(
              child: const Text("Pick a Green Color"),
              onPressed: () {
                // Send back a green color when button is pressed
                Navigator.pop(context, Colors.green);
              },
            ),
            ElevatedButton(
              child: const Text("Pick a Blue Color"),
              onPressed: () {
                // Send back a blue color when button is pressed
                Navigator.pop(context, Colors.blue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
