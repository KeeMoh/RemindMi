import 'package:flutter/material.dart';
import 'package:remind_mi/pages/form_page.dart';
import 'package:remind_mi/utils/charter.dart';

class AddReminderButton extends StatefulWidget {
  final Map<String, dynamic>? data;
  const AddReminderButton({super.key, this.data});

  @override
  State<AddReminderButton> createState() => _AddReminderButtonState();
}

class _AddReminderButtonState extends State<AddReminderButton> {
  final _controller = TextEditingController();
  // AddReminderButton toDoListPage = const AddReminderButton();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            shadowColor: Colors.black,
            backgroundColor: Charter.secondarycolor,
            foregroundColor: Charter.primarycolor,
            elevation: 10,
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(5)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormPage()),
          );
        },
        child: const Center(
            child: Text(
          "Ajouter une tâche",
          style: TextStyle(fontSize: 20),
        )),
      ),
    );
  }
}
