import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarMonth extends StatefulWidget {
  final Map<String, dynamic> data;
  const CalendarMonth({Key? key, required this.data}) : super(key: key);

  @override
  State<CalendarMonth> createState() => _CalendarMonthState();
}

class _CalendarMonthState extends State<CalendarMonth> {
  @override
  Widget build(BuildContext context) {
    CalendarView view = widget.data['calendarView'];
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenWidth,
      width: screenWidth,
      child: SfCalendar(
        view: view,
        //! complete dataSource
        dataSource: widget.data["reminders"],

        // by default the month appointment display mode set as Indicator, we can
        // change the display mode as appointment using the appointment display
        // mode property
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
    );
  }
}
