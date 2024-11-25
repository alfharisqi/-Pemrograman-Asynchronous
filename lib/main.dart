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

  // Metode baru yang akan melemparkan exception setelah delay 2 detik
  Future<void> returnError() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulasi delay
    throw Exception('Something terrible happened!'); // Melemparkan exception
  }

  // Fungsi untuk mendapatkan angka dengan menggunakan Completer
  Future<int> getNumber() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulasi delay
    return 42; // Nilai yang diselesaikan
  }

  // Langkah 5: Menambahkan metode returnFG dengan Future.wait
  void returnFG() {
    // Menggunakan Future.wait untuk menunggu beberapa Future secara paralel
    final futures = Future.wait<int>([
      returnOneAsync(),
      returnTwoAsync(),
      returnThreeAsync(),
    ]);

    // Menunggu semua Future selesai
    futures.then((List<int> values) {
      int total = 0;
      for (var value in values) {
        total += value; // Menghitung total dari hasil Future
      }
      setState(() {
        result = total.toString(); // Menampilkan total hasil
      });
    }).catchError((e) {
      setState(() {
        result = 'An error occurred'; // Menangani kesalahan
      });
    });
  }

  // Asynchronous functions to be used in returnFG
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
                // Mengganti kode di onPressed dengan memanggil returnFG()
                returnFG();
              },
            ),
            ElevatedButton(
              child: const Text('Trigger Error'),
              onPressed: () {
                // Menggunakan then, catchError, dan whenComplete untuk menangani returnError
                returnError().then((value) {
                  setState(() {
                    result = 'Success'; // Menampilkan pesan "Success" jika tidak ada error
                  });
                }).catchError((onError) {
                  setState(() {
                    result = onError.toString(); // Menampilkan pesan error jika terjadi error
                  });
                }).whenComplete(() {
                  print('Complete'); // Menampilkan "Complete" setelah selesai
                });
              },
            ),
            const SizedBox(height: 20),
            result.isNotEmpty
                ? Text(result) // Menampilkan hasil
                : const Text("Press GO! to calculate."),
          ],
        ),
      ),
    );
  }
}
