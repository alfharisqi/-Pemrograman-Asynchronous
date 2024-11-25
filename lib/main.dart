import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'geolocation.dart';
import 'navigation_first.dart';
import 'navigation_second.dart';

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
      //home: const FuturePage(),
      //home: LocationScreen(),
      //home: const NavigationFirst(),
      home: const NavigationFirst(),
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

  Future<void> returnError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Something terrible happened!');
  }

  Future<void> handleError() async {
    try {
      await returnError();
    } catch (error) {
      setState(() {
        result = error.toString();
      });
    } finally {
      print('Complete');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Demo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Handle Error with then'),
                onPressed: () {
                  returnError()
                      .then((value) {
                    setState(() {
                      result = 'Success';
                    });
                  })
                      .catchError((onError) {
                    setState(() {
                      result = onError.toString();
                    });
                  })
                      .whenComplete(() => print('Complete'));
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Handle Error with try-catch'),
                onPressed: () {
                  handleError();
                },
              ),
              const SizedBox(height: 20),
              Text(
                result,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/junbDwAAQBAJ';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }
}