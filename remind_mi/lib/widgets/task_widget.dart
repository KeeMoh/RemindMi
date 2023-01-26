import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      .map((element) => Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Container(
              color: HexColor(element.background),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 50,
                        child: Center(
                            child: Text(getTimeBeforeReminder(element)))),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: false,
                            builder: (context) => FormPage(reminder: element))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        element.title.length > 80
                            ? element.title.substring(0, 80) + " (...)"
                            : element.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
                  FloatingActionButton(
                      backgroundColor: Charter.secondarycolor,
                      mini: true,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: false,
                                builder: (context) =>
                                    FormPage(reminder: element)));
                      },
                      child: const Icon(Icons.edit, size: 20)),
                  FloatingActionButton(
                      backgroundColor: Color.fromARGB(170, 255, 55, 0),
                      mini: true,
                      onPressed: () {
                        //supress actual reminder
                        //reminders.add(Reminder(_controller.text));
                        setState(() {
                          reminders.remove(element);
                        });
                      },
                      child: const Icon(Icons.delete, size: 20)),
                ],
              ),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
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
