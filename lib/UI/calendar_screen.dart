import 'package:drtime_patients/shared/widgets/doctor_card.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DoctorCard(
            doctorField: 'coventry',
            doctorName: 'Kung Pao',
            time: 'Friday at 14:00PM',
            appointmentCard: true,
            showDoctorField: false,
          ),
          DoctorCard(
            doctorField: 'coventry',
            doctorName: 'Kung Pao',
            time: 'Tuesday at 11:00AM',
            appointmentCard: true,
            showDoctorField: false,
            petDoctor: true,
          ),
          DoctorCard(
            doctorField: 'coventry',
            doctorName: 'Kung Pao',
            time: '14:00PM',
            appointmentCard: true,
            showDoctorField: false,
          ),
          DoctorCard(
            doctorField: 'coventry',
            doctorName: 'Kung Pao',
            time: 'Friday at 14:00PM',
            appointmentCard: true,
            showDoctorField: false,
            petDoctor: true,
          ),
          DoctorCard(
            doctorField: 'coventry',
            doctorName: 'Kung Pao',
            time: 'Friday at 14:00PM',
            showDoctorField: false,
            appointmentCard: true,
          ),
        ],
      ),
    );
  }
}
