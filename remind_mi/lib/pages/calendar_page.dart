import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
      height: _screenWidth,
      width: _screenWidth,
      child: SfCalendar(
        view: CalendarView.month,
        //! complete dataSource
        // dataSource: MeetingDataSource(_getDataSource()),

        // by default the month appointment display mode set as Indicator, we can
        // change the display mode as appointment using the appointment display
        // mode property
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
    ));
  }
}
