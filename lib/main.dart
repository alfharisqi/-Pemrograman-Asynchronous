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
    calculate2(); // Memanggil metode baru calculate2
    return completer.future;
  }

  // Mengganti metode calculate() dengan calculate2()
  Future<void> calculate2() async {
    try {
      await Future.delayed(const Duration(seconds: 5)); // Delay 5 detik
      completer.complete(42); // Menyelesaikan dengan nilai 42
      throw Exception(); // Menyebabkan kesalahan untuk menguji error handling
    } catch (_) {
      completer.completeError("An error occurred during calculation"); // Menangani kesalahan
    }
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
                // Langkah 6: Pindah ke onPressed() dan perbarui dengan kode berikut
                getNumber().then((value) {
                  setState(() {
                    result = value.toString(); // Menampilkan hasil
                  });
                }).catchError((e) {
                  setState(() {
                    result = 'An error occurred'; // Menangani kesalahan
                  });
                });
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
