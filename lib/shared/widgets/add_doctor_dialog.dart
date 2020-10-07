import 'package:drtime_patients/shared/widgets/add_doctor_model.dart';
import 'package:drtime_patients/shared/widgets/custom_dialog.dart';
import 'package:drtime_patients/shared/widgets/custom_raised_button.dart';
import 'package:drtime_patients/shared/widgets/custom_textfield.dart';
import 'package:drtime_patients/shared/widgets/doctor_provider.dart';
import 'package:drtime_patients/shared/widgets/show_alert_dialog.dart';
import 'package:drtime_patients/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDoctorDialogBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddDoctorModel>(
      create: (_) => AddDoctorModel(),
      child: Consumer<AddDoctorModel>(
        builder: (_, model, __) => _AddDoctorDialog(
          model: model,
        ),
      ),
    );
  }
}

class _AddDoctorDialog extends StatefulWidget {
  final AddDoctorModel model;
  const _AddDoctorDialog({@required this.model});

  @override
  _AddDoctorDialogState createState() => _AddDoctorDialogState();
}

class _AddDoctorDialogState extends State<_AddDoctorDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();
  final FocusScopeNode _node = FocusScopeNode();
  AddDoctorModel get model => widget.model;

  Future<void> _submit() async {
    try {
      final bool success = await model.submit();
      DoctorScreenProvider provider =
          Provider.of<DoctorScreenProvider>(context, listen: false);
      if (success) {
        provider.addDoctorCard(
          doctorName: model.name,
          specialty: model.specialty,
          petDoctor: model.petDoctor,
        );
        Navigator.pop(context);
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      _showSignInError(model, e);
      Navigator.pop(context);
    }
  }

  void _showSignInError(AddDoctorModel model, dynamic exception) async {
    await showAlertDialog(
      context: context,
      title: model.errorAlertTitle,
      content: exception.toString(),
      defaultActionText: Strings.ok,
    );
  }

  void _displayNameEditingComplete() {
    if (model.canSubmitName) {
      _node.nextFocus();
    }
  }

  void _specialtyEditingComplete() {
    if (!model.canSubmitSpecialty) {
      _node.previousFocus();
    }

    _submit();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: Strings.addDoctorTitle,
      content: FocusScope(
        node: _node,
        child: Column(
          children: [
            CustomTextField(
              controller: _nameController,
              hint: Strings.nameHint,
              errorText: model.nameErrorText,
              onChanged: model.updateName,
              enabled: !model.isLoading,
              onEditingComplete: _displayNameEditingComplete,
            ),
            CustomTextField(
              controller: _specialtyController,
              hint: Strings.specialtyHint,
              errorText: model.specialtyErrorText,
              enabled: !model.isLoading,
              onChanged: model.updateSpecialty,
              onEditingComplete: _specialtyEditingComplete,
              textInputAction: TextInputAction.done,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pet Doctor?'),
                Checkbox(
                  value: model.petDoctor,
                  onChanged: model.updatePetDoctor,
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomRaisedButton(
                height: MediaQuery.of(context).size.height * 0.06,
                label: model.primaryButtonText,
                loading: model.isLoading,
                onTap: model.isLoading ? null : _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
