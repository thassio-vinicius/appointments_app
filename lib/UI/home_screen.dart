import 'dart:async';

import 'package:drtime_patients/shared/widgets/doctor_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _opacity = 0;

  @override
  void initState() {
    _fadeInTransition();
    super.initState();
  }

  _fadeInTransition() {
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 1000),
          child: ListView(
            children: [
              DoctorCard(
                doctorField: 'Dentistry',
                doctorName: 'Xin',
                time: '12:00AM',
              ),
              DoctorCard(
                doctorField: 'Psychiatry',
                doctorName: 'Romelu Lukaku',
                time: '12:00AM',
              ),
              DoctorCard(
                doctorField: 'Internal Med.',
                doctorName: 'Eden Hazard',
                time: '12:00AM',
              ),
              DoctorCard(
                doctorField: 'Pediatry',
                doctorName: 'Neymar Junior',
                time: '12:00AM',
              ),
            ],
          )),
    );
  }
}
