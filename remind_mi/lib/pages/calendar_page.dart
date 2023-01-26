import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:remind_mi/models/reminder.dart';
import 'package:remind_mi/models/reminder_data_source.dart';
import 'package:remind_mi/models/reminders.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:remind_mi/widgets/add_reminder_button.dart';
import 'package:remind_mi/widgets/add_reminder_floatingButton.dart';
import 'package:remind_mi/widgets/calendar/calendar_month.dart';
import 'package:remind_mi/widgets/custom_menu.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarController _controller = CalendarController();
  late CalendarView calendarView;
  late ReminderDataSource reminders;
  Color? _viewHeaderColor = Charter.secondarycolor,
      _calendarColor = Charter.white;

  @override
  void initState() {
    print("initState");
    calendarView = CalendarView.month;
    reminders = ReminderDataSource(Reminders.reminders);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final get calendarView{}
    var data = {"calendarView": calendarView, "reminders": reminders};
    CalendarMonth calendarMonth;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Agenda"),
        actions: [CustomMenu()],
      ),
      body: Column(
        children: [
          Expanded(
            // height: screenWidth,
            // width: screenWidth,
            child: SfCalendar(
              view: CalendarView.month,
              allowedViews: [
                // CalendarView.day,
                CalendarView.week,
                // CalendarView.workWeek,
                CalendarView.month,
                // CalendarView.timelineDay,
                // CalendarView.timelineWeek,
                // CalendarView.timelineWorkWeek
              ],
              viewHeaderStyle:
                  ViewHeaderStyle(backgroundColor: _viewHeaderColor),
              backgroundColor: _calendarColor,
              controller: _controller,
              initialDisplayDate: DateTime.now(),
              dataSource: ReminderDataSource(Reminders.reminders),
              onTap: calendarTapped,
              monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),
              // monthViewSettings: MonthViewSettings(
              //     navigationDirection: MonthNavigationDirection.vertical),
            ),
            // dataSource: widget.data["reminders"],

            // // by default the month appointment display mode set as Indicator, we can
            // // change the display mode as appointment using the appointment display
            // // mode property
            // monthViewSettings: const MonthViewSettings(
            //     appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          _controller.view = CalendarView.month;
                        },
                        child: Text("Mois")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          _controller.view = CalendarView.week;
                        },
                        child: Text("Semaine")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          _controller.view = CalendarView.day;
                        },
                        child: Text("Jour")),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const AddReminderFloatingButton(),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (_controller.view == CalendarView.month ||
        _controller.view == CalendarView.week) {
      _controller.view = CalendarView.day;
    }
    // else if (_controller.view == CalendarView.day) {
    //   Navigator.of(context).push(FormPage(reminder: calendarTapDetails.targetElement))
    // }
  }
}
