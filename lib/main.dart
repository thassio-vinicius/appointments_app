import 'package:drtime_patients/UI/splash_screen.dart';
import 'package:drtime_patients/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UI/tabs/calendar_tab/calendar_screen_provider.dart';
import 'UI/tabs/doctor_tab/doctor_screen_provider.dart';
import 'UI/tabs/today_tab/today_screen_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() {
  runApp(DrTime());
}

class DrTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DoctorScreenProvider>(
          create: (_) => DoctorScreenProvider(),
        ),
        ChangeNotifierProvider<TodayScreenProvider>(
          create: (_) => TodayScreenProvider(),
        ),
        ChangeNotifierProvider<CalendarScreenProvider>(
          create: (_) => CalendarScreenProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
            cardColor: HexColor('BEEAF5'),
            scaffoldBackgroundColor: Colors.white,
            primaryColor: HexColor('08BAFF')),
      ),
    );
  }
}
