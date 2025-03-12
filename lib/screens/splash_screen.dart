import 'dart:async';
import 'package:flutter/material.dart';
import 'package:home_services/screens/walk_through_screen.dart';
import 'package:home_services/utils/images.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WalkThroughScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Image.asset(
          new_splash_logo, 
          width: 150, 
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
