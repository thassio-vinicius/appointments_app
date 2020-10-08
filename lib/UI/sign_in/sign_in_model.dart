import 'package:drtime_patients/utils/strings.dart';
import 'package:drtime_patients/utils/validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignInModel with TextFieldValidators, ChangeNotifier {
  SignInModel({
    this.email = '',
    this.password = '',
    this.phoneNumber = '',
    this.displayName = '',
    this.isLoading = false,
    this.submitted = false,
  });

  String email;
  String password;
  String phoneNumber;
  String displayName;
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

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updatePhoneNumber(String phoneNumber) =>
      updateWith(phoneNumber: phoneNumber);

  void updateDisplayName(String displayName) =>
      updateWith(displayName: displayName);

  void updateWith({
    String email,
    String password,
    String displayName,
    String phoneNumber,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.phoneNumber = phoneNumber ?? this.phoneNumber;
    this.displayName = displayName ?? this.displayName;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }

  // Getters
  String get primaryButtonText {
    return Strings.signInConfirm;
  }

  String get errorAlertTitle {
    return Strings.signInFailed;
  }

  String get title {
    return Strings.signInTitle;
  }

  bool get canSubmitEmail {
    return emailSubmitValidator.isValid(email) && email.isNotEmpty;
  }

  bool get canSubmitPassword {
    return passwordSubmitValidator.isValid(password) && password.isNotEmpty;
  }

  bool get canSubmitDisplayName {
    return displayNameSubmitValidator.isValid(displayName) &&
        displayName.isNotEmpty;
  }

  bool get canSubmitPhoneNumber {
    return phoneNumberSubmitValidator.isValid(phoneNumber) &&
        phoneNumber.isNotEmpty;
  }

  bool get canSubmit {
    bool canSubmitFields;

    canSubmitFields = canSubmitEmail &&
        canSubmitPassword &&
        canSubmitPhoneNumber &&
        canSubmitDisplayName;

    print(canSubmitFields);
    return canSubmitFields && !isLoading;
  }

  String get emailErrorText {
    final bool showErrorText = submitted && !canSubmitEmail;
    final String errorText = email.isEmpty
        ? Strings.invalidEmailEmpty
        : Strings.invalidEmailErrorText;
    return showErrorText ? errorText : null;
  }

  String get passwordErrorText {
    final bool showErrorText = submitted && !canSubmitPassword;
    final String errorText = password.isEmpty
        ? Strings.invalidPasswordEmpty
        : Strings.invalidPasswordTooShort;
    return showErrorText ? errorText : null;
  }

  String get phoneNumberErrorText {
    final bool showErrorText = submitted && !canSubmitPhoneNumber;
    final String errorText = phoneNumber.isEmpty
        ? Strings.invalidPhoneNumberEmpty
        : Strings.invalidPhoneNumberErrorText;
    return showErrorText ? errorText : null;
  }

  String get displayNameErrorText {
    final bool showErrorText = submitted && !canSubmitDisplayName;
    final String errorText = displayName.isEmpty
        ? Strings.invalidDisplayNameEmpty
        : Strings.invalidDisplayNameTooShort;
    return showErrorText ? errorText : null;
  }

  @override
  String toString() {
    return 'email: $email, displayName: $displayName, password: $password, phoneNumber: $phoneNumber, isLoading: $isLoading, submitted: $submitted';
  }
}
