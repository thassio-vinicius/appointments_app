import 'package:drtime_patients/shared/widgets/custom_dialog.dart';
import 'package:drtime_patients/shared/widgets/custom_raised_button.dart';
import 'package:drtime_patients/shared/widgets/custom_textfield.dart';
import 'package:drtime_patients/shared/widgets/doctor_card.dart';
import 'package:drtime_patients/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorScreen extends StatefulWidget {
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              DoctorCard(
                doctorName: 'Kung Pao',
                appointmentCard: false,
                doctorField: 'Dentistry',
              ),
              DoctorCard(
                doctorName: 'Kung Pao',
                appointmentCard: false,
                doctorField: 'Dentistry',
              ),
              DoctorCard(
                doctorName: 'Kung Pao',
                appointmentCard: false,
                doctorField: 'Dentistry',
              ),
              DoctorCard(
                doctorName: 'Kung Pao',
                appointmentCard: false,
                doctorField: 'Dentistry',
              ),
              DoctorCard(
                doctorName: 'Kung Pao',
                appointmentCard: false,
                doctorField: 'Dentistry',
                petDoctor: true,
              ),
              DoctorCard(
                doctorName: 'Kung Pao',
                appointmentCard: false,
                doctorField: 'Dentistry',
                petDoctor: true,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (_) {
                  final TextEditingController nameController =
                      TextEditingController();
                  final TextEditingController fieldController =
                      TextEditingController();
                  final FocusScopeNode node = FocusScopeNode();

                  bool showNameError = false;
                  bool showFieldError = false;

                  return CustomDialog(
                    title: Strings.addDoctorTitle,
                    content: FocusScope(
                      node: node,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: nameController,
                            hint: Strings.nameHint,
                            errorText: showNameError ? Strings.nameError : null,
                            enabled: true,
                          ),
                          CustomTextField(
                            controller: fieldController,
                            hint: Strings.fieldHint,
                            errorText:
                                showFieldError ? Strings.fieldError : null,
                            enabled: true,
                            textInputAction: TextInputAction.done,
                          ),
                          CustomRaisedButton(
                            label: Strings.confirm,
                            onTap: () {
                              if (nameController.text.isNotEmpty &&
                                  fieldController.text.isNotEmpty) {
                                Navigator.pop(context);
                              } else {
                                if (nameController.text.isEmpty) {
                                  setState(() {
                                    showNameError = true;
                                  });
                                }

                                if (fieldController.text.isEmpty) {
                                  setState(() {
                                    showFieldError = true;
                                  });
                                }
                                return;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              child: Text(
                Strings.addDoctor,
                style: TextStyle(
                  fontSize: 17,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
