import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remind_mi/models/reminder.dart';
import 'package:remind_mi/models/reminders.dart';
import 'package:remind_mi/pages/form_page.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:remind_mi/utils/hex_color.dart';

class ReminderWidget extends StatefulWidget {
  const ReminderWidget({super.key});

  @override
  State<ReminderWidget> createState() => _ReminderWidgetState();
}

class _ReminderWidgetState extends State<ReminderWidget> {
  List<Reminder> reminders = Reminders.reminders;

  get cardsWidget => reminders
      .map((element) => element.endDate.isBefore(DateTime.now())
          ? const SizedBox()
          : Padding(
              key: ValueKey(element.ref?.id),
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                color: HexColor(element.background),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 50,
                          child: Center(
                              child: Text(
                                  textAlign: TextAlign.center,
                                  getTimeBeforeReminder(element)))),
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: false,
                              builder: (context) => FormPage(
                                    reminder: element,
                                    beginDate: element.startDate,
                                    endDate: element.endDate,
                                  ))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          element.title.length > 80
                              ? "${element.title.substring(0, 80)} (...)"
                              : element.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    IconButton(
                        key: const ValueKey('editButton'),
                        // backgroundColor: Charter.secondarycolor,
                        // mini: true,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: false,
                                  builder: (context) => FormPage(
                                        reminder: element,
                                        beginDate: element.startDate,
                                        endDate: element.endDate,
                                      )));
                        },
                        icon: const Icon(Icons.edit, size: 20)),
                    IconButton(
                        // backgroundColor: Color.fromARGB(170, 255, 55, 0),
                        // mini: true,
                        key: const ValueKey('deleteButton'),
                        onPressed: () {
                          //supress actual reminder
                          //reminders.add(Reminder(_controller.text));
                          element.delete();
                          setState(() {
                            reminders.remove(element);
                          });
                        },
                        icon: const Icon(Icons.delete, size: 20)),
                  ],
                ),
              ),
            ))
      .toList();

  @override
  Widget build(BuildContext context) {
    reminders.sort((a, b) => a.startDate.compareTo(b.startDate));
    return ListView(
      children: cardsWidget,
    );
  }

  String getTimeBeforeReminder(Reminder reminder) {
    Duration test = reminder.startDate.difference(DateTime.now());
    if (test.inDays > 1) {
      return "${test.inDays}j";
    }
    if (test.inHours > 3) {
      return "${test.inHours}h";
    }
    if (test.inHours >= 1) {
      return "${test.inHours}h${test.inMinutes % 60}";
    }
    if (test.inMinutes > 0) {
      return "${test.inMinutes}m";
    }
    return "En cours";
  }
}
