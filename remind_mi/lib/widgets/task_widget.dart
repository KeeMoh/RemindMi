import 'package:flutter/material.dart';
import 'package:remind_mi/models/reminders.dart';
import 'package:remind_mi/pages/form_page.dart';
import 'package:remind_mi/utils/charter.dart';

class ReminderWidget extends StatefulWidget {
  const ReminderWidget({super.key});

  @override
  State<ReminderWidget> createState() => _ReminderWidgetState();
}

class _ReminderWidgetState extends State<ReminderWidget> {
  get cardsWidget => Reminders.reminders
      .map((element) => Padding(
            key: ValueKey(element.ref?.id),
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
                                builder: (context) => FormPage(
                                      docReference: element.ref,
                                    )));
                      },
                      child: const Icon(Icons.edit, size: 20)),
                  FloatingActionButton(
                      backgroundColor: const Color.fromARGB(170, 255, 55, 0),
                      mini: true,
                      onPressed: () {
                        //supress actual reminder
                        //reminders.add(Reminder(_controller.text));
                        element.delete();
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
}
