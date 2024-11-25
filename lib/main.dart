import 'dart:async';
import 'package:flutter/material.dart';
import 'package:async/async.dart'; // Impor package async.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Completer Demo',
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

  // Variabel Completer
  late Completer<int> completer;

  // Fungsi untuk mendapatkan angka dengan menggunakan Completer
  Future<int> getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  // Fungsi untuk melakukan perhitungan setelah delay
  Future<void> calculate() async {
    await Future.delayed(const Duration(seconds: 5));
    completer.complete(42);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completer Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('GO!'),
              onPressed: () {
                // Kode yang diminta untuk mengganti onPressed()
                getNumber().then((value) {
                  setState(() {
                    result = value.toString(); // Menampilkan hasil
                  });
                }).catchError((e) {
                  setState(() {
                    result = "Error: $e"; // Menangani kesalahan
                  });
                });

                // Kode sebelumnya yang sekarang dikomentari:
                // getNumber().then((value) {
                //   setState(() {
                //     result = "Result: $value";
                //   });
                // }).catchError((e) {
                //   setState(() {
                //     result = "Error: $e";
                //   });
                // });
              },
            ),
            const SizedBox(height: 20),
            result.isNotEmpty
                ? Text(result)
                : const Text("Press GO! to calculate."),
          ],
        ),
      ),
    );
  }
}
