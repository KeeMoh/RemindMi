import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:remind_mi/models/model.dart';
import 'package:remind_mi/pages/todo_list_page.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:remind_mi/widgets/add_reminder_form.dart';

class AddReminderButton extends StatefulWidget {
  const AddReminderButton({super.key});

  @override
  State<AddReminderButton> createState() => _AddReminderButtonState();
}

class _AddReminderButtonState extends State<AddReminderButton> {
  final _controller = TextEditingController();
  AddReminderButton toDoListPage = const AddReminderButton();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    setState(() {});
  }

  // void updateReminderList(text) {
  //   print("mise à jour !");
  //   Reminder.reminders.add(Reminder(text));
  //   setState(() {});
  //   // toDoListPage.updateReminderList(text);
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.65,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: Charter.secondarycolor,
            foregroundColor: Charter.primarycolor,
            elevation: 3,
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.all(5)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  fullscreenDialog: false,
                  builder: (context) => const AddReminderForm()));
        },
        child: Center(
            child: Text(
          "Ajouter une tâche",
          style: TextStyle(fontSize: 20),
        )),
      ),
    );
  }
}
