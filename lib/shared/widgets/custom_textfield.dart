import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String errorText;
  final Function(String) onChanged;
  final void Function(PhoneNumber) onPhoneNumberChanged;
  final Function onEditingComplete;
  final TextInputType textInputType;
  final bool obscure;
  final bool autoCorrect;
  final bool enabled;
  final bool isPhoneNumberField;
  final String hint;
  final Function(bool) onPhoneNumberValidated;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;

  CustomTextField({
    @required this.controller,
    @required this.errorText,
    @required this.enabled,
    @required this.hint,
    this.onEditingComplete,
    this.onPhoneNumberValidated,
    this.onPhoneNumberChanged,
    this.onChanged,
    this.isPhoneNumberField = false,
    this.textInputType = TextInputType.text,
    this.obscure = false,
    this.autoCorrect = false,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: isPhoneNumberField
              ? InternationalPhoneNumberInput(
                  textFieldController: controller,
                  inputDecoration: InputDecoration(
                    enabled: enabled,
                    errorText: errorText,
                    hintText: hint,
                  ),
                  selectorConfig: SelectorConfig(
                    showFlags: true,
                    useEmoji: false,
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  initialValue: PhoneNumber(isoCode: 'US'),
                  hintText: '',
                  keyboardAction: textInputAction,
                  onInputChanged: onPhoneNumberChanged,
                  onInputValidated: onEditingComplete,
                )
              : TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    errorText: errorText,
                    enabled: enabled,
                    hintText: hint,
                  ),
                  obscureText: obscure,
                  autocorrect: autoCorrect,
                  textInputAction: textInputAction,
                  keyboardAppearance: Brightness.light,
                  onChanged: onChanged,
                  onEditingComplete: onEditingComplete,
                  inputFormatters: inputFormatters,
                ),
        ),
      ),
    );
  }
}
