import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:remind_mi/models/model.dart';
import 'package:remind_mi/pages/home_page.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:remind_mi/widgets/add_reminder_button.dart';
import 'package:remind_mi/widgets/add_reminder_form.dart';
import 'package:remind_mi/widgets/custom_menu.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  int cards = 5;
  List<Reminder> reminders = [];

  void updateReminderList(text) {
    print("mise à jour !");
    Reminder.reminders.add(Reminder(text));
    setState(() {});
    // toDoListPage.updateReminderList(text);
  }

  void addReminder() {
    setState(() {});
  }

  void fillReminders() {
    for (var i = 0; i < cards; i++) reminders.add(Reminder("texte"));
  }

  List<Padding> get cardsWidget => reminders
      .map((element) => Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Container(
              color: Charter.green,
              child: ListTile(
                  tileColor: Charter.green,
                  title: Text(element.label),
                  trailing: FloatingActionButton(
                      onPressed: () {
                        //supress actual reminder
                        //reminders.add(Reminder(_controller.text));
                        setState(() {
                          reminders.remove(element);
                        });
                      },
                      child: Icon(element.icon))),
            ),
          ))
      .toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = TextEditingController();
    fillReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Charter.red,
          title: Text('Liste des tâches'),
          centerTitle: true,
          actions: [CustomMenu()]),
      body: Column(
        children: [
          // Container(
          //   color: Charter.background,
          // child: Padding(
          //   padding: EdgeInsets.all(10.0),
          //   child: Card(
          //     color: Charter.red,
          // child: ListTile(
          // contentPadding: EdgeInsets.only(left: 5, right: 15),
          // trailing:

          // ),
          // ),
          // ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: AddReminderButton(),
          ),
          Expanded(
            child: Container(
              color: Charter.background,
              child: ListView(
                children: cardsWidget,
              ),
            ),
          )
          // Container(
          //   color: Colors.blue,
          //   child: Row(
          //     children: [
          //       Flexible(
          //         flex: 7,
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Row(
          //             children: [
          //               Container(child: Text("monTexte")),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Flexible(flex: 1, child: Icon(Icons.access_alarm))
          //     ],
          //   ),
          // ),

          // ListView(
          //   children: [
          //     ListTile(
          //       trailing: Text("test"),
          //       title: Text("hahaha"),
          //     ),
          //     ListTile(
          //       trailing: Text("test"),
          //       title: Text("hahaha"),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
