import 'dart:io';

import 'package:drtime_patients/mocks/datetime_mock.dart';
import 'package:drtime_patients/shared/widgets/doctor_card.dart';
import 'package:drtime_patients/utils/hex_color.dart';
import 'package:drtime_patients/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'appointment_confirm_screen.dart';

class AppointmentScreen extends StatefulWidget {
  final String name;
  final String specialty;
  final bool petDoctor;
  const AppointmentScreen({
    @required this.name,
    @required this.specialty,
    @required this.petDoctor,
  });

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  bool _fromTimeAfter = false;
  TabController _tabController;
  DateTime _pickedDateFrom = DateTime.now();
  DateTime _pickedDateTo = DateTime.now();
  TimeOfDay _timeFrom = TimeOfDay.now();
  TimeOfDay _timeTo = TimeOfDay.now();
  List<String> _appointments = AppointmentsMock.createRandomDateTimes();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _backButton(),
                ),
              ),
              DoctorCard(
                doctorName: widget.name,
                showDoctorSpecialty: true,
                doctorSpecialty: widget.specialty,
                petDoctor: widget.petDoctor,
                appointmentCard: false,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: HexColor('EEEEEE')),
                    padding: EdgeInsets.all(2),
                    child: DefaultTabController(
                      initialIndex: 0,
                      length: 2,
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        labelColor: Colors.black,
                        unselectedLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(text: Strings.soonestAvailable),
                          Tab(text: Strings.fitSchedule)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [_appointmentsList(false), _scheduleView()]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scheduleView() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: HexColor('F4F4F4'),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _datePickerRow(true),
              _datePickerRow(false),
              _timePickerRow(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: _filteredAppointments().isEmpty
                  ? Center(
                      child: Text(
                        _fromTimeAfter
                            ? Strings.fromTimeAfter
                            : Strings.noAppointmentsSchedule,
                        style: TextStyle(
                          color: _fromTimeAfter
                              ? Colors.red
                              : Theme.of(context).primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : _appointmentsList(true)),
        ),
      ],
    );
  }

  _timePickerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _timePicker(true),
        Text(
          Strings.to,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        _timePicker(false)
      ],
    );
  }

  _timePicker(bool from) {
    return GestureDetector(
      onTap: () => _showTimePicker(from),
      child: Container(
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.04,
        decoration: BoxDecoration(
            color: HexColor('E5E5E5'),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        padding: EdgeInsets.all(4),
        child: Text(
          from ? _timeFrom.format(context) : _timeTo.format(context),
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  _showTimePicker(bool from) async {
    TimeOfDay result = await showTimePicker(
            context: context,
            initialTime: from ? _timeFrom : _timeTo,
            initialEntryMode: TimePickerEntryMode.dial) ??
        TimeOfDay.now();

    if (from) {
      setState(() {
        _timeFrom = result;
      });
    } else {
      setState(() {
        _timeTo = result;
      });
    }

    if (_timeFrom.hour > _timeTo.hour) {
      if (_timeFrom.minute > _timeTo.minute) {
        setState(() {
          _fromTimeAfter = true;
        });
      } else {
        setState(() {
          _fromTimeAfter = false;
        });
      }
    } else {
      setState(() {
        _fromTimeAfter = false;
      });
    }
  }

  Widget _datePickerRow(bool from) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            from ? Strings.from : Strings.to,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () => Platform.isIOS
                ? _buildCupertinoDatePicker(from)
                : _buildMaterialDatePicker(from),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.04,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: HexColor('E5E5E5'),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              padding: EdgeInsets.all(4),
              child: Text(
                DateFormat.MMMMd()
                    .format(from ? _pickedDateFrom : _pickedDateTo),
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildMaterialDatePicker(bool from) async {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: CalendarDatePicker(
              initialCalendarMode: DatePickerMode.day,
              initialDate: from ? _pickedDateFrom : _pickedDateTo,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 366)),
              onDateChanged: (date) {
                if (from) {
                  setState(() {
                    _pickedDateFrom = date;
                  });
                } else {
                  setState(() {
                    _pickedDateTo = date;
                  });
                }
                if (_pickedDateFrom.isAfter(_pickedDateTo)) {
                  Fluttertoast.showToast(
                      msg: "From date can't be after To date");
                } else {
                  Navigator.pop(context);
                }
              }),
        ),
      ),
    );
  }

  _buildCupertinoDatePicker(bool from) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: GestureDetector(
              child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: false,
                  initialDateTime: from ? _pickedDateFrom : _pickedDateTo,
                  minimumYear: DateTime.now().year,
                  minimumDate: DateTime.now(),
                  onDateTimeChanged: (date) {
                    if (from) {
                      setState(() {
                        _pickedDateFrom = date;
                      });
                    } else {
                      setState(() {
                        _pickedDateTo = date;
                      });
                    }

                    if (_pickedDateFrom.isAfter(_pickedDateTo)) {
                      Fluttertoast.showToast(
                          msg: "From date can't be after To date");
                    } else {
                      Navigator.pop(context);
                    }
                  }),
              onTap: () => Navigator.pop(context)),
        ),
      ),
    );
  }

  Widget _appointmentsList(bool filter) {
    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: filter ? _filteredAppointments().length : _appointments.length,
      itemBuilder: (context, index) => _appointmentCard(
          filter ? _filteredAppointments()[index] : _appointments[index]),
    );
  }

  List<String> _filteredAppointments() {
    List<String> results = _appointments.where((element) {
      bool pm = element.split(',').first.contains('pm');
      List<String> time = element.split(':');
      int hour = int.parse(time.first);
      hour = pm ? hour + 12 : hour;
      //int minute = int.parse(time.last.substring(0, 2));

      List<String> date = element.split(',').last.trim().split('.');

      int month = int.parse(date.first);
      int day = int.parse(date[1]);

      DateTime comparable = DateTime(2021, month, day);

      return comparable.isAfter(_pickedDateFrom) &&
          comparable.isBefore(_pickedDateTo) &&
          hour >= _timeFrom.hour &&
          hour <= _timeTo.hour;
    }).toList();

    return results;
  }

  Widget _appointmentCard(String appointment) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AppointmentConfirmScreen(
                      appointment: appointment,
                      doctorName: widget.name,
                      doctorSpecialty: widget.specialty,
                      petDoctor: widget.petDoctor,
                    ))),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: HexColor('F4F4F4'),
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.07,
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appointment,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward,
                    color: HexColor('1F7DEA'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      padding: EdgeInsets.all(4),
      child: FlatButton.icon(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back,
          color: HexColor('30B8F1'),
        ),
        label: Text(
          'Back',
          style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
