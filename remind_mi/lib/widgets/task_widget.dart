import 'package:flutter/material.dart';
import 'package:remind_mi/models/reminder.dart';
import 'package:remind_mi/models/reminders.dart';
import 'package:remind_mi/pages/form_page.dart';
import 'package:remind_mi/utils/charter.dart';

class ReminderWidget extends StatefulWidget {
  final List<Reminder> listEvents;
  const ReminderWidget({super.key, required this.listEvents});

  @override
  State<ReminderWidget> createState() => _ReminderWidgetState();
}

class _ReminderWidgetState extends State<ReminderWidget> {
  get cardsWidget => widget.listEvents
      .map((element) => 
            Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              color: Charter.secondarycolor[600],
              child: Row(
                children: [
                  Expanded(child: Text(element.title)),
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
                      backgroundColor: const Color.fromARGB(170, 255, 55, 0),
                      mini: true,
                      onPressed: () {
                        //supress actual reminder
                        //reminders.add(Reminder(_controller.text));
                        deleteEvent();
                      },
                      child: const Icon(Icons.delete, size: 20)),
                ],
              ),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    print(widget.listEvents);
    return ListView(
      children: cardsWidget,
    );
  }
}

Future deleteEvent() async {
  print("delete");
}
