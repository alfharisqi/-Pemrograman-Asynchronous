import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = "";
  // String futureResults = ""; // Tidak digunakan pada pembaruan ini.

  // Future<http.Response> getData() async {
  //   const authority = 'www.googleapis.com';
  //   const path = '/books/v1/volumes/R4qsDwAAQBAJ';
  //   Uri url = Uri.https(authority, path);
  //   return http.get(url);
  // }

  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  // Future<void> fetchAllFutures() async {
  //   try {
  //     final results = await Future.wait([
  //       returnOneAsync(),
  //       returnTwoAsync(),
  //       returnThreeAsync(),
  //     ]);
  //     setState(() {
  //       futureResults = "Results: ${results.join(', ')}";
  //     });
  //   } catch (e) {
  //     setState(() {
  //       futureResults = "An error occurred while fetching results";
  //     });
  //   }
  // }

  Future<void> count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();
    setState(() {
      result = "Sum: $total";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back from the Future'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('GO!'),
              onPressed: () {
                count(); // Langsung memanggil metode count.
              },
            ),
            const SizedBox(height: 20),
            result.isNotEmpty
                ? Text(result)
                : const Text("Press GO! to calculate sum."),
            // const SizedBox(height: 20),
            // const CircularProgressIndicator(), // Dikomentari karena tidak digunakan.
          ],
        ),
      ),
    );
  }
}
