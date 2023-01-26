import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:remind_mi/models/reminder.dart';
import 'package:remind_mi/models/reminders.dart';
import 'package:remind_mi/pages/home_page.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:remind_mi/widgets/add_reminder_button.dart';
import 'package:remind_mi/widgets/add_reminder_floatingButton.dart';
import 'package:remind_mi/widgets/custom_menu.dart';
import 'package:remind_mi/widgets/task_widget.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  int cards = 2;
  List<Reminder> reminders = Reminders.reminders;

  get cardsWidget => reminders.isEmpty
      ? const Center(
          child: Text(
            "Vous n'avez pas de tâches à venir ...",
            style: TextStyle(color: Charter.white),
          ),
        )
      : const ReminderWidget();

  @override
  void initState() {
    super.initState();
    // _controller = TextEditingController();
    // fillReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Charter.secondarycolor,
          automaticallyImplyLeading: false,
          title: const Text('Tâches à venir'),
          centerTitle: true,
          actions: const [CustomMenu()]),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Container(color: Charter.primarycolor, child: cardsWidget),
          )
        ],
      ),
      floatingActionButton: const AddReminderButton(),
    );
  }
}
