import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:remind_mi/pages/calendar_page.dart';
import 'package:remind_mi/pages/home_page.dart';
import 'package:remind_mi/pages/main_page.dart';
import 'package:remind_mi/pages/todo_list_page.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:remind_mi/widgets/add_reminder_form.dart';

class CustomMenu extends StatelessWidget {
  const CustomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        // shape: ShapeBorder(OutlinedBorder(side: )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        color: Charter.white,
        offset: Offset(20, 50),
        itemBuilder: (context) => [
              PopupMenuItem(
                  child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: false,
                              builder: (context) => const HomePage())),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Charter.red),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Accueil")
                        ],
                      ))),
              PopupMenuItem(
                  child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: false,
                              builder: (context) => const CalendarPage())),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Charter.red),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Agenda")
                        ],
                      ))),
              PopupMenuItem(
                  child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: false,
                              builder: (context) => const ToDoList())),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Charter.red),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Évènements")
                        ],
                      ))),
            ]);
  }
}
