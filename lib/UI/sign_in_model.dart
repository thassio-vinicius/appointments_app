import 'package:drtime_patients/utils/strings.dart';
import 'package:drtime_patients/utils/validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EmailPasswordSignInModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailPasswordSignInModel({
    this.email = '',
    this.password = '',
    this.phoneNumber = '',
    this.isLoading = false,
    this.submitted = false,
    this.usernameTaken = false,
  });

  String email;
  String password;
  String phoneNumber;
  bool isLoading;
  bool submitted;
  bool usernameTaken;

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

  void updateConfirmPassword(String confirmPassword) =>
      updateWith(confirmPassword: confirmPassword);

  void updatePhoneNumber(String phoneNumber) =>
      updateWith(phoneNumber: phoneNumber);

  void updateUsername(String username) {
    updateWith(username: username, usernameTaken: false);
  }

  void updateDisplayName(String displayName) =>
      updateWith(displayName: displayName);

  void updateFormType() {
    updateWith(
      email: '',
      password: '',
      displayName: '',
      username: '',
      confirmPassword: '',
      phoneNumber: '',
      isLoading: false,
      submitted: false,
      usernameTaken: false,
    );
  }

  void updateWith({
    String email,
    String password,
    String username,
    String displayName,
    String phoneNumber,
    String confirmPassword,
    bool isLoading,
    bool submitted,
    bool usernameTaken,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.phoneNumber = phoneNumber ?? this.phoneNumber;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.usernameTaken = usernameTaken ?? this.usernameTaken;
    notifyListeners();
  }

  String get passwordLabelText {
    return Strings.password8CharactersLabel;
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
    return emailSubmitValidator.isValid(email);
  }

  bool get canSubmitPassword {
    return passwordSignInSubmitValidator.isValid(password);
  }

  bool get canSubmitPhoneNumber {
    return phoneNumberSubmitValidator.isValid(phoneNumber) &&
        phoneNumber.isNotEmpty;
  }

  bool get canSubmit {
    bool canSubmitFields;

    canSubmitFields =
        canSubmitEmail && canSubmitPassword && canSubmitPhoneNumber;

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

  @override
  String toString() {
    return 'email: $email, password: $password, phoneNumber: $phoneNumber, isLoading: $isLoading, submitted: $submitted';
  }
}
