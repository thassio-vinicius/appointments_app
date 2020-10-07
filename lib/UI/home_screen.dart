import 'dart:async';

import 'package:drtime_patients/UI/calendar_screen.dart';
import 'package:drtime_patients/UI/doctor_screen.dart';
import 'package:drtime_patients/UI/today_screen.dart';
import 'package:drtime_patients/utils/hex_color.dart';
import 'package:drtime_patients/utils/image_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0;
  int _currentIndex = 0;

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _tabTitle(),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              child: Image(image: AssetImage(Images.settings)),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _tabController,
                            children: [
                              TodayScreen(),
                              DoctorScreen(),
                              CalendarScreen()
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0, bottom: 12.0),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                offset: Offset(6, 0),
                                color: HexColor('#CFCFCF'),
                                spreadRadius: 4)
                          ],
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide.none),
                          labelPadding: const EdgeInsets.all(12),
                          onTap: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          tabs: [
                            RotatedBox(
                                quarterTurns: 3,
                                child: Image(
                                    image: AssetImage(_currentIndex == 0
                                        ? Images.starSelected
                                        : Images.starUnselected))),
                            RotatedBox(
                                quarterTurns: 3,
                                child: Image(
                                    image: AssetImage(_currentIndex == 1
                                        ? Images.glassesSelected
                                        : Images.glassesUnselected))),
                            RotatedBox(
                                quarterTurns: 3,
                                child: Image(
                                    image: AssetImage(_currentIndex == 2
                                        ? Images.calendarSelected
                                        : Images.calendarUnselected))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _titles = ['Today', 'My Doctors', 'Medical Calendar'];

  Widget _tabTitle() => Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          _titles[_currentIndex],
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
