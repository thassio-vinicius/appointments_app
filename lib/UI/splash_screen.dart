import 'dart:async';

import 'package:drtime_patients/UI/sign_in/sign_in_screen.dart';
import 'package:drtime_patients/UI/tabs/home_screen.dart';
import 'package:drtime_patients/utils/customfade_route.dart';
import 'package:drtime_patients/utils/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;
  var _duration = Duration(milliseconds: 500);

  _handleSplashFade(bool fadeIn) {
    Timer(_duration, () {
      setState(() {
        _opacity = fadeIn ? 1 : 0;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _handleSplashFade(true);
    _checkForUserFirstTime();
  }

  _checkForUserFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool signedIn = prefs.getBool('signedIn') ?? false;
    var duration = Duration(milliseconds: 2000);

    ///this is only used for testing purposes when [SignInScreen()] needs to be tested
    bool testSignIn = false;

    if (signedIn && !testSignIn) {
      return Timer(
        duration,
        () => _fadeOutNavigation(
            pageRoute: HomeScreen(), routeName: 'HomeScreen'),
      );
    } else {
      return Timer(
          duration,
          () => _fadeOutNavigation(
              pageRoute: SignInScreen(), routeName: 'SignInScreen'));
    }
  }

  _fadeOutNavigation({Widget pageRoute, String routeName}) {
    Navigator.pushReplacement(
        context, CustomFadeRoute(child: pageRoute, routeName: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: _duration,
      opacity: _opacity,
      onEnd: () => _handleSplashFade(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image(image: AssetImage(Images.splashLogo)),
        ),
      ),
    );
  }
}
