import 'package:flutter/material.dart';
import 'package:remind_mi/models/reminder_data_source.dart';
import 'package:remind_mi/models/reminders.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:remind_mi/widgets/add_reminder_floatingButton.dart';
import 'package:remind_mi/widgets/bottom_nav.dart';
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
  final Color _viewHeaderColor = Charter.secondarycolor,
      _calendarColor = Charter.white;

  @override
  void initState() {
    calendarView = CalendarView.month;
    reminders = ReminderDataSource(Reminders.reminders);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Agenda"),
        actions: const [CustomMenu()],
      ),
      body: Column(
        children: [
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              allowedViews: const [
                // CalendarView.day,
                CalendarView.week,
                // CalendarView.workWeek,
                CalendarView.month,
                // CalendarView.timelineDay,
                // CalendarView.timelineWeek,
                // CalendarView.timelineWorkWeek
              ],
              viewHeaderStyle:
                  ViewHeaderStyle(backgroundColor: Charter.secondarycolor[300]),
              backgroundColor: _calendarColor,
              controller: _controller,
              initialDisplayDate: DateTime.now(),
              dataSource: ReminderDataSource(Reminders.reminders),
              onTap: calendarTapped,
              monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),
            ),
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
                        child: const Text("Mois")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          _controller.view = CalendarView.week;
                        },
                        child: const Text("Semaine")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          _controller.view = CalendarView.day;
                        },
                        child: const Text("Jour")),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const AddReminderFloatingButton(),
      // bottomNavigationBar: const BottomNav(),
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
