import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remind_mi/models/reminder.dart';
import 'package:remind_mi/models/reminders.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:remind_mi/widgets/add_reminder_button.dart';
import 'package:remind_mi/widgets/custom_menu.dart';
import 'package:remind_mi/widgets/task_widget.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Charter.secondarycolor,
          title: const Text('Liste des tâches'),
          centerTitle: true,
          actions: const [CustomMenu()]),
      body: StreamBuilder<List<Reminder>>(
          stream: readReminders(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Une erreur est survenue ! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final reminders = snapshot.data!;
              Reminders.reminders = reminders;
              return (Reminders.reminders.isEmpty)
                  ? const Center(
                      child: Text(
                        "Vous n'avez pas de tâches à venir ...",
                        style: TextStyle(color: Charter.white),
                      ),
                    )
                  : (const ReminderWidget());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: const AddReminderButton(),
    );
  }
}

Stream<List<Reminder>> readReminders() => FirebaseFirestore.instance
    .collection('reminder_collection')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('reminders')
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => Reminder.fromJson(doc.data(), ref: doc.reference))
        .toList());
