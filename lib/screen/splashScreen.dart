import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const screenRoute = '/SplashScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
            height: 200,
            width: 200,
            child: Image.asset('assets/image/logo.png')),
      ),
    );
  }
}
