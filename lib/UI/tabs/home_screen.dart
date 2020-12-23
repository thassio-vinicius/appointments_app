import 'dart:async';

import 'package:drtime_patients/UI/sign_in/sign_in_screen.dart';
import 'package:drtime_patients/UI/tabs/doctor_tab/doctor_screen.dart';
import 'package:drtime_patients/UI/tabs/today_tab/today_screen.dart';
import 'package:drtime_patients/shared/widgets/custom_dialog.dart';
import 'package:drtime_patients/utils/hex_color.dart';
import 'package:drtime_patients/utils/image_helper.dart';
import 'package:drtime_patients/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'calendar_tab/calendar_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0;
  int _currentIndex = 0;
  String _displayName = '';

  TabController _tabController;

  _getDisplayName() async {
    var prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('displayName') ?? 'John';
    setState(() {
      _displayName = name;
    });
  }

  @override
  void initState() {
    _getDisplayName();
    _tabController = TabController(length: 3, vsync: this);
    _fadeInTransition();
    super.initState();
  }

  _fadeInTransition() {
    Timer(Duration(milliseconds: 500), () {
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
        duration: Duration(milliseconds: 500),
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
                              onTap: () => showDialog(
                                context: context,
                                builder: (_) => CustomDialog(
                                  heightPercentage: 0.35,
                                  title: Strings.settings,
                                  content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07,
                                              decoration: BoxDecoration(
                                                color: HexColor('08BAFF'),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  _displayName
                                                      .substring(0, 1)
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: HexColor('007AFF'),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                _displayName,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                CupertinoIcons.minus_circle,
                                                color: HexColor('017BFF'),
                                                size: 30,
                                              ),
                                              onPressed: () async {
                                                var prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setBool(
                                                    'signedIn', false);
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            SignInScreen()));
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.lock,
                                              color: HexColor('08BAFF'),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(Strings.lock),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.comment,
                                              color: HexColor('08BAFF'),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(Strings.manageAlerts),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.help_outline,
                                              color: HexColor('08BAFF'),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                Strings.getHelp,
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          Strings.policy,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: HexColor('08BAFF'),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              child: Image(
                                image: AssetImage(Images.settings),
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.06,
                              ),
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

  Widget _tabTitle() => Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          Strings.tabs[_currentIndex],
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
