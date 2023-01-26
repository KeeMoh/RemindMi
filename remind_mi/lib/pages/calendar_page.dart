import 'package:flutter/material.dart';
import 'package:remind_mi/models/reminder_data_source.dart';
import 'package:remind_mi/models/reminders.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:remind_mi/widgets/add_reminder_floating_button.dart';
import 'package:remind_mi/widgets/custom_menu.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final CalendarController _controller = CalendarController();
  late CalendarView calendarView;
  late ReminderDataSource reminders;
  final Color _viewHeaderColor = Charter.red, _calendarColor = Charter.white;

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
              todayHighlightColor: _viewHeaderColor,
              firstDayOfWeek: 1,
              view: CalendarView.month,
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
        ],
      ),
      floatingActionButton: const AddReminderFloatingButton(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Charter.secondarycolor[500],
        backgroundColor: Charter.primarycolor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_month),
            label: 'Mois',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_week),
            label: 'Semaine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day),
            label: 'Jour',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Charter.secondarycolor,
        onTap: _onItemTapped,
      ),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (_controller.view == CalendarView.month ||
        _controller.view == CalendarView.week) {
      _controller.view = CalendarView.day;
    }
    setState(() {
      _selectedIndex = 2;
    });
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        _controller.view = CalendarView.month;
        break;
      case 1:
        _controller.view = CalendarView.week;
        break;
      case 2:
        _controller.view = CalendarView.day;
        break;
      default:
    }
    setState(() {
      _selectedIndex = index;
    });
  }
}
