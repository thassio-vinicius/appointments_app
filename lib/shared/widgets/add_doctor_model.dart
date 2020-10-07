import 'package:drtime_patients/utils/strings.dart';
import 'package:drtime_patients/utils/validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddDoctorModel with TextFieldValidators, ChangeNotifier {
  AddDoctorModel({
    this.name = '',
    this.specialty = '',
    this.isLoading = false,
    this.submitted = false,
    this.petDoctor = false,
  });

  String name;
  String specialty;
  bool petDoctor;
  bool isLoading;
  bool submitted;

  Future<bool> submit() async {
    print('submit');

    try {
      updateWith(submitted: true);
      if (!canSubmit) {
        print('cant submit');
        return false;
      }
      updateWith(isLoading: true);
      return true;
    } catch (e, stackTrace) {
      print(stackTrace);
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateName(String name) => updateWith(name: name);

  void updateSpecialty(String specialty) => updateWith(specialty: specialty);
  void updatePetDoctor(bool petDoctor) => updateWith(petDoctor: petDoctor);

  void updateWith({
    String name,
    String specialty,
    bool isLoading,
    bool submitted,
    bool petDoctor,
  }) {
    this.name = name ?? this.name;
    this.specialty = specialty ?? this.specialty;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.petDoctor = petDoctor ?? this.petDoctor;
    notifyListeners();
  }

  // Getters
  String get primaryButtonText {
    return Strings.confirm;
  }

  String get errorAlertTitle {
    return Strings.addDoctorFailed;
  }

  String get title {
    return Strings.addDoctorTitle;
  }

  bool get canSubmitName {
    return displayNameSubmitValidator.isValid(name) && name.isNotEmpty;
  }

  bool get canSubmitSpecialty {
    return displayNameSubmitValidator.isValid(specialty) &&
        specialty.isNotEmpty;
  }

  bool get canSubmit {
    bool canSubmitFields;

    canSubmitFields = canSubmitName && canSubmitSpecialty;

    print(canSubmitFields);
    return canSubmitFields && !isLoading;
  }

  String get nameErrorText {
    final bool showErrorText = submitted && !canSubmitName;
    final String errorText = name.isEmpty
        ? Strings.invalidDoctorNameEmpty
        : Strings.invalidDoctorNameTooShort;
    return showErrorText ? errorText : null;
  }

  String get specialtyErrorText {
    final bool showErrorText = submitted && !canSubmitSpecialty;
    final String errorText = specialty.isEmpty
        ? Strings.invalidSpecialtyEmpty
        : Strings.invalidSpecialtyTooShort;
    return showErrorText ? errorText : null;
  }

  @override
  String toString() {
    return 'name: $name, specialty: $specialty, petDoctor: $petDoctor';
  }
}
