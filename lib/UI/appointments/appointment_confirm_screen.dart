import 'package:drtime_patients/UI/tabs/calendar_tab/calendar_screen_provider.dart';
import 'package:drtime_patients/UI/tabs/home_screen.dart';
import 'package:drtime_patients/UI/tabs/today_tab/today_screen_provider.dart';
import 'package:drtime_patients/shared/widgets/custom_raised_button.dart';
import 'package:drtime_patients/utils/hex_color.dart';
import 'package:drtime_patients/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentConfirmScreen extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialty;
  final String appointment;
  final bool petDoctor;
  final String photo;

  const AppointmentConfirmScreen({
    @required this.appointment,
    @required this.doctorName,
    @required this.doctorSpecialty,
    @required this.petDoctor,
    this.photo,
  });
  @override
  _AppointmentConfirmScreenState createState() => _AppointmentConfirmScreenState();
}

class _AppointmentConfirmScreenState extends State<AppointmentConfirmScreen> with SingleTickerProviderStateMixin {
  String _displayName = '';
  int _currentIndex = 0;
  TabController _tabController;
  TextEditingController _notesController;

  _getDisplayName() async {
    var prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('displayName') ?? 'John';
    setState(() {
      _displayName = name;
    });
  }

  @override
  void initState() {
    _notesController = TextEditingController();
    _tabController = TabController(length: 4, vsync: this);
    _getDisplayName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _appointmentCard(),
                    Text(
                      'For',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    _buildTabBar(),
                    _notesTextField(),
                    GestureDetector(
                      child: Text(
                        Strings.cancel,
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                    CustomRaisedButton(
                        label: Strings.confirm,
                        onTap: () {
                          Provider.of<CalendarScreenProvider>(context, listen: false).addDoctorCard(
                            doctorName: widget.doctorName,
                            specialty: widget.doctorSpecialty,
                            appointment: widget.appointment,
                            petDoctor: widget.petDoctor,
                          );

                          if (int.parse(widget.appointment.split('.')[1]) == DateTime.now().day) {
                            Provider.of<TodayScreenProvider>(context, listen: false).addDoctorCard(
                              doctorName: widget.doctorName,
                              specialty: widget.doctorSpecialty,
                              time: widget.appointment.split(',').first,
                              petDoctor: widget.petDoctor,
                            );
                          }

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _notesTextField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: HexColor('EEEEEE'),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(12),
      child: TextField(
        controller: _notesController,
        minLines: 1,
        maxLines: 6,
        decoration: InputDecoration(
          hintText: Strings.notesHint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          //width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.04,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: HexColor('EEEEEE')),
          padding: EdgeInsets.all(2),
          child: DefaultTabController(
            initialIndex: _currentIndex,
            length: 4,
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
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
                Tab(text: _displayName.split(' ').first ?? _displayName),
                Tab(text: 'Ann'),
                Tab(text: 'John'),
                Tab(text: 'Max'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appointmentCard() {
    return Container(
      decoration: BoxDecoration(
        color: widget.petDoctor ? HexColor('#93D8CA') : Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Stack(
        children: [
          Positioned(top: 0, left: 0, child: _buildPhotoCard()),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Appointment with Dr. ${widget.doctorName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.doctorSpecialty,
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.petDoctor ? HexColor('24AF93') : Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  widget.appointment,
                  style: TextStyle(color: widget.petDoctor ? Colors.black : HexColor('017AFD'), fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildPhotoCard() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: widget.photo == null ? HexColor('E5E5E5') : Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.06),
          )
        ],
      ),
      child: widget.photo == null
          ? Center(
              child: Text(
                '?',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            )
          : Image.asset(
              widget.photo,
              fit: BoxFit.cover,
            ),
    );
  }
}
