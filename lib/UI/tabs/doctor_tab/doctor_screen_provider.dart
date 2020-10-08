import 'package:drtime_patients/UI/appointments/appointment_screen.dart';
import 'package:drtime_patients/main.dart';
import 'package:drtime_patients/shared/widgets/doctor_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DoctorScreenProvider extends ChangeNotifier {
  List<DoctorCard> _doctorCards = [];
  List<DoctorCard> get doctorCards => _doctorCards;

  void addDoctorCard(
      {@required String doctorName,
      @required String specialty,
      bool petDoctor = false}) {
    var card = DoctorCard(
      doctorName: doctorName,
      doctorSpecialty: specialty,
      appointmentCard: false,
      petDoctor: petDoctor,
      showDoctorSpecialty: true,
      onTap: () => navigatorKey.currentState.push(
        MaterialPageRoute(
          builder: (_) => AppointmentScreen(
            name: doctorName,
            specialty: specialty,
            petDoctor: petDoctor,
          ),
        ),
      ),
    );

    _doctorCards.add(card);

    notifyListeners();
  }
}
