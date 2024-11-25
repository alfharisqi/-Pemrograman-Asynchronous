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

  // Langkah 5: Menambahkan metode returnFG
  void returnFG() {
    // Membuat FutureGroup untuk mengelola beberapa Future secara paralel
    FutureGroup<int> futureGroup = FutureGroup<int>();
    futureGroup.add(returnOneAsync());
    futureGroup.add(returnTwoAsync());
    futureGroup.add(returnThreeAsync());
    futureGroup.close();

    // Menunggu semua Future selesai
    futureGroup.future.then((List<int> value) {
      int total = 0;
      for (var element in value) {
        total += element; // Menghitung total dari hasil Future
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
                // Langkah 2: Mengganti kode di onPressed dengan memanggil returnFG()
                returnFG();
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
