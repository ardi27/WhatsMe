import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whatsme/presentation/screens/home_screen.dart';
import 'package:whatsme/presentation/screens/registration_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => RegistrationScreen()),
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("WhatsMe",style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
    );
  }
}
