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
            doctorSpecialty: 'coventry',
            doctorName: 'Kung Pao',
            time: 'Friday at 14:00PM',
            appointmentCard: true,
            showDoctorSpecialty: false,
          ),
          DoctorCard(
            doctorSpecialty: 'coventry',
            doctorName: 'Kung Pao',
            time: 'Tuesday at 11:00AM',
            appointmentCard: true,
            showDoctorSpecialty: false,
            petDoctor: true,
          ),
          DoctorCard(
            doctorSpecialty: 'coventry',
            doctorName: 'Kung Pao',
            time: '14:00PM',
            appointmentCard: true,
            showDoctorSpecialty: false,
          ),
          DoctorCard(
            doctorSpecialty: 'coventry',
            doctorName: 'Kung Pao',
            time: 'Friday at 14:00PM',
            appointmentCard: true,
            showDoctorSpecialty: false,
            petDoctor: true,
          ),
          DoctorCard(
            doctorSpecialty: 'coventry',
            doctorName: 'Kung Pao',
            time: 'Friday at 14:00PM',
            showDoctorSpecialty: false,
            appointmentCard: true,
          ),
        ],
      ),
    );
  }
}
