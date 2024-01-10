import 'dart:async';

import 'package:background_tracker/home_screen.dart';
import 'package:background_tracker/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LocationUpdateScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyanAccent,
        child: const Text(
          'Splash Screen',
          maxLines: 1,
          style: TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }
}