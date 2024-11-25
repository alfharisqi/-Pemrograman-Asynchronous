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

  Future<http.Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/R4qsDwAAQBAJ';
    Uri url = Uri.https(authority, path);
    return http.get(url);
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
                setState(() {}); // Memulai animasi loading jika diperlukan.
                getData()
                    .then((value) {
                  setState(() {
                    // Menampilkan 450 karakter pertama dari respons.
                    result = value.body.toString().substring(0, 450);
                  });
                })
                    .catchError((_) {
                  setState(() {
                    result = 'An error occurred'; // Menangani kesalahan.
                  });
                });
              },
            ),
            const SizedBox(height: 20),
            result.isNotEmpty
                ? Text(result)
                : const Text("No data yet. Press GO! to fetch."),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Indikator loading.
          ],
        ),
      ),
    );
  }
}

