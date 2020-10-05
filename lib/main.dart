import 'package:drtime_patients/UI/splash_screen.dart';
import 'package:drtime_patients/utils/hex_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DrTime());
}

class DrTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: HexColor('08BAFF')),
    );
  }
}
