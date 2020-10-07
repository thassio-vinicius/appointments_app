import 'package:drtime_patients/UI/splash_screen.dart';
import 'package:drtime_patients/shared/widgets/doctor_provider.dart';
import 'package:drtime_patients/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: HexColor('08BAFF')),
      ),
    );
  }
}
