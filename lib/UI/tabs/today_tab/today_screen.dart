import 'package:drtime_patients/UI/tabs/today_tab/today_screen_provider.dart';
import 'package:drtime_patients/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayScreen extends StatefulWidget {
  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<TodayScreenProvider>(
        builder: (_, provider, __) => Column(
            children: provider.doctorCards.isEmpty
                ? [
                    Center(
                      child: Text(
                        Strings.noAppointments,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ]
                : provider.doctorCards),
      ),
    );
  }
}
