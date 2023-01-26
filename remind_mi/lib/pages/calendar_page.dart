import 'package:flutter/material.dart';
import 'package:remind_mi/models/reminder_data_source.dart';
import 'package:remind_mi/models/reminders.dart';
import 'package:remind_mi/widgets/add_reminder_floating_button.dart';
import 'package:remind_mi/widgets/calendar/calendar_month.dart';
import 'package:remind_mi/widgets/custom_menu.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late CalendarView calendarView;
  late ReminderDataSource reminders;

  @override
  void initState() {
    calendarView = CalendarView.month;
    reminders = ReminderDataSource(Reminders.reminders);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final get calendarView{}
    var data = {"calendarView": calendarView, "reminders": reminders};
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Agenda"),
        actions: const [CustomMenu()],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        data["calendarView"] = CalendarView.week;
                        print("setState");
                        print(data);
                      });
                    },
                    child: const Text("Changer de format"))
              ],
            ),
          ),
          CalendarMonth(data: data),
        ],
      ),
      floatingActionButton: const AddReminderFloatingButton(),
    );
  }

  void switchCalendarView(view) {
    // calendarView = view;
    setState(() {});
  }

  // List<Reminder> _getDataSource() {
  //   final List<Reminder> reminders = <Reminder>[];
  //   final DateTime today = DateTime.now();
  //   final DateTime startDate = DateTime(today.year, today.month, today.day, 9);
  //   final DateTime endDate = startDate.add(const Duration(hours: 2));
  //   reminders.add(Reminder(
  //       userID: "", //FirebaseAuth.instance.currentUser!.uid
  //       title: 'Conference',
  //       startDate: startDate,
  //       endDate: endDate));
  //   return reminders;
  // }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
// class Meeting {
//   /// Creates a meeting class with required details.
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

//   /// Event name which is equivalent to subject property of [Appointment].
//   String eventName;

//   /// From which is equivalent to start time property of [Appointment].
//   DateTime from;

//   /// To which is equivalent to end time property of [Appointment].
//   DateTime to;

//   /// Background which is equivalent to color property of [Appointment].
//   Color background;

//   /// IsAllDay which is equivalent to isAllDay property of [Appointment].
//   bool isAllDay;
// }
