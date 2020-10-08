import 'package:drtime_patients/shared/widgets/doctor_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CalendarScreenProvider extends ChangeNotifier {
  List<DoctorCard> _doctorCards = [];
  List<DoctorCard> get doctorCards => _doctorCards;

  void addDoctorCard(
      {@required String doctorName,
      @required String specialty,
      @required String appointment,
      bool petDoctor = false}) {
    var card = DoctorCard(
      doctorName: doctorName,
      doctorSpecialty: specialty,
      appointmentCard: true,
      petDoctor: petDoctor,
      showDoctorSpecialty: false,
      appointment: appointment,
    );

    _doctorCards.add(card);

    notifyListeners();
  }
}
