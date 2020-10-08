import 'package:drtime_patients/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calendar_screen_provider.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<CalendarScreenProvider>(
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
