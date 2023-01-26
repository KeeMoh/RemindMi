import 'package:flutter/material.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarMonth extends StatefulWidget {
  final Map<String, dynamic> data;
  const CalendarMonth({Key? key, required this.data}) : super(key: key);

  @override
  State<CalendarMonth> createState() => _CalendarMonthState();
}

class _CalendarMonthState extends State<CalendarMonth> {
  final CalendarController _controller = CalendarController();
  Color? _viewHeaderColor = Charter.secondarycolor,
      _calendarColor = Charter.white;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // height: screenWidth,
      // width: screenWidth,
      child: SfCalendar(
        view: CalendarView.week,
        allowedViews: const [
          CalendarView.day,
          CalendarView.week,
          // CalendarView.workWeek,
          CalendarView.month,
          CalendarView.timelineDay,
          CalendarView.timelineWeek,
          // CalendarView.timelineWorkWeek
        ],
        viewHeaderStyle: ViewHeaderStyle(backgroundColor: _viewHeaderColor),
        backgroundColor: _calendarColor,
        controller: _controller,
        initialDisplayDate: DateTime.now(),
        dataSource: widget.data["reminders"],
        onTap: calendarTapped,
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        // monthViewSettings: MonthViewSettings(
        //     navigationDirection: MonthNavigationDirection.vertical),
      ),
      // dataSource: widget.data["reminders"],

      // // by default the month appointment display mode set as Indicator, we can
      // // change the display mode as appointment using the appointment display
      // // mode property
      // monthViewSettings: const MonthViewSettings(
      //     appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    print("Lololo");
    if (_controller.view == CalendarView.month &&
        calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      _controller.view = CalendarView.day;
    } else if ((_controller.view == CalendarView.week ||
            _controller.view == CalendarView.workWeek) &&
        calendarTapDetails.targetElement == CalendarElement.viewHeader) {
      _controller.view = CalendarView.day;
    }
  }

  void viewChange() {
    print("TRololo");
    if (_controller.view == CalendarView.week) {
      _controller.view = CalendarView.month;
    } else if (_controller.view == CalendarView.month) {
      _controller.view = CalendarView.week;
    }
  }
}
