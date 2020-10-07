import 'package:drtime_patients/utils/hex_color.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String doctorSpecialty;
  final String time;
  final String photo;
  final bool appointmentCard;
  final bool showDoctorSpecialty;
  final bool petDoctor;
  final Function onTap;

  const DoctorCard({
    @required this.doctorName,
    @required this.appointmentCard,
    this.doctorSpecialty,
    this.time,
    this.photo,
    this.showDoctorSpecialty = true,
    this.petDoctor = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color: HexColor(petDoctor ? '#93D8CA' : '#BEEAF5'),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    color: photo == null ? Colors.grey : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.06),
                      )
                    ],
                  ),
                  child: photo == null
                      ? Center(
                          child: Text(
                            '?',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )
                      : Image.asset(
                          photo,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Flexible(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      appointmentCard
                          ? Text(
                              'Appointment with Dr. $doctorName',
                              style: TextStyle(
                                fontSize: 15,
                                color: petDoctor
                                    ? HexColor('24AF93')
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Text(
                              'Dr. $doctorName',
                              style: TextStyle(
                                fontSize: 17,
                                color: petDoctor
                                    ? HexColor('24AF93')
                                    : Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (showDoctorSpecialty)
                            Text(
                              doctorSpecialty,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          if (appointmentCard)
                            Text(
                              time,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: petDoctor
                                      ? HexColor('24AF93')
                                      : Theme.of(context).primaryColor,
                                  fontSize: 17),
                            )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
