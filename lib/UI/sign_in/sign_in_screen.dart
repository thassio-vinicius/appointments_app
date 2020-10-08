import 'dart:async';

import 'package:drtime_patients/UI/sign_in/sign_in_model.dart';
import 'package:drtime_patients/UI/tabs/home_screen.dart';
import 'package:drtime_patients/shared/widgets/custom_raised_button.dart';
import 'package:drtime_patients/shared/widgets/custom_textfield.dart';
import 'package:drtime_patients/shared/widgets/show_alert_dialog.dart';
import 'package:drtime_patients/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: Consumer<SignInModel>(
        builder: (_, model, __) => _EmailPasswordSignInPage(model: model),
      ),
    );
  }
}

class _EmailPasswordSignInPage extends StatefulWidget {
  const _EmailPasswordSignInPage({@required this.model});
  final SignInModel model;

  @override
  _EmailPasswordSignInPageState createState() =>
      _EmailPasswordSignInPageState();
}

class _EmailPasswordSignInPageState extends State<_EmailPasswordSignInPage> {
  final FocusScopeNode _node = FocusScopeNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  double _opacity = 0;

  SignInModel get model => widget.model;

  @override
  void initState() {
    _fadeInTransition();
    super.initState();
  }

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _showSignInError(SignInModel model, dynamic exception) async {
    await showAlertDialog(
      context: context,
      title: model.errorAlertTitle,
      content: exception.toString(),
      defaultActionText: Strings.ok,
    );
  }

  _fadeInTransition() {
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  Future<void> _submit() async {
    try {
      final bool success = await model.submit();
      if (success) {
        var prefs = await SharedPreferences.getInstance();
        prefs.setBool('signedIn', true);
        prefs.setString('displayName', _displayNameController.text);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      _showSignInError(model, e);
    }
  }

  void _emailEditingComplete() {
    if (model.canSubmitEmail) {
      _node.nextFocus();
    }
  }

  void _phoneNumberEditingComplete() {
    if (model.canSubmitPhoneNumber) {
      _node.nextFocus();
    }
  }

  void _displayNameEditingComplete() {
    if (model.canSubmitDisplayName) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!model.canSubmitPassword) {
      _node.previousFocus();
    }

    _submit();
  }

  _onPhoneNumberChanged(number) {
    String parsedNumber = number.phoneNumber
        .replaceAll('${number.dialCode}', '')
        .replaceAll('+', '');

    if (parsedNumber.isEmpty) {
      model.updatePhoneNumber(parsedNumber);
    } else {
      print(number.phoneNumber);

      model.updatePhoneNumber(number.phoneNumber);
    }
  }

  Widget _buildFields() {
    List<Widget> children = <Widget>[
      CustomTextField(
          controller: _emailController,
          hint: Strings.emailHint,
          errorText: model.emailErrorText,
          onChanged: model.updateEmail,
          enabled: !model.isLoading,
          onEditingComplete: _emailEditingComplete,
          textInputType: TextInputType.emailAddress,
          inputFormatters: <TextInputFormatter>[model.emailInputFormatter]),
      CustomTextField(
        controller: _displayNameController,
        hint: Strings.displayNameHint,
        errorText: model.displayNameErrorText,
        onChanged: model.updateDisplayName,
        enabled: !model.isLoading,
        onEditingComplete: _displayNameEditingComplete,
      ),
      CustomTextField(
        isPhoneNumberField: true,
        hint: Strings.phoneHint,
        controller: _phoneNumberController,
        errorText: model.phoneNumberErrorText,
        onPhoneNumberChanged: _onPhoneNumberChanged,
        onPhoneNumberValidated: (number) => _phoneNumberEditingComplete,
        enabled: !model.isLoading,
      ),
      CustomTextField(
        controller: _passwordController,
        hint: Strings.passwordHint,
        errorText: model.passwordErrorText,
        enabled: !model.isLoading,
        obscure: true,
        onChanged: model.updatePassword,
        onEditingComplete: _passwordEditingComplete,
        textInputAction: TextInputAction.done,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: CustomRaisedButton(
          height: MediaQuery.of(context).size.height * 0.06,
          label: model.primaryButtonText,
          width: MediaQuery.of(context).size.width * 0.80,
          loading: model.isLoading,
          onTap: model.isLoading ? null : _submit,
        ),
      ),
    ];

    return Column(children: children);
  }

  Widget _buildContent() {
    return FocusScope(
      node: _node,
      child: _buildFields(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(milliseconds: 1000),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0, left: 14.0),
                    child: Text(
                      model.title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0), child: _buildContent()),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.11,
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '${Strings.useTermsConfirm}\n',
                style: TextStyle(fontSize: 15, color: Colors.black),
                children: [
                  TextSpan(
                    text: Strings.drTime,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
