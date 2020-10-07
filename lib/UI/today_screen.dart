import 'package:drtime_patients/shared/widgets/doctor_card.dart';
import 'package:flutter/material.dart';

class TodayScreen extends StatefulWidget {
  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        DoctorCard(
          doctorSpecialty: 'coventry',
          doctorName: 'Kung Pao',
          time: '14:00PM',
          appointmentCard: true,
        ),
        DoctorCard(
          doctorSpecialty: 'coventry',
          doctorName: 'Kung Pao',
          time: '14:00PM',
          appointmentCard: true,
        ),
        DoctorCard(
          doctorSpecialty: 'coventry',
          doctorName: 'Kung Pao',
          time: '14:00PM',
          appointmentCard: true,
        ),
        DoctorCard(
          doctorSpecialty: 'coventry',
          doctorName: 'Kung Pao',
          time: '14:00PM',
          appointmentCard: true,
        ),
        DoctorCard(
          doctorSpecialty: 'coventry',
          doctorName: 'Kung Pao',
          time: '14:00PM',
          appointmentCard: true,
        ),
        DoctorCard(
          doctorSpecialty: 'coventry',
          doctorName: 'Kung Pao',
          time: '14:00PM',
          appointmentCard: true,
          petDoctor: true,
        ),
        DoctorCard(
          doctorSpecialty: 'coventry',
          doctorName: 'Kung Pao',
          time: '14:00PM',
          appointmentCard: true,
          petDoctor: true,
        ),
      ]),
    );
  }
}
