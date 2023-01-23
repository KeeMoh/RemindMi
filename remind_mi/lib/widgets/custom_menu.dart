import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
                  child: Row(
                children: [
                  Icon(Icons.star, color: Charter.red),
                  SizedBox(
                    // sized box with width 10
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: false,
                              builder: (context) => const AddReminderForm())),
                      child:
                          Hero(tag: 'test', child: Text("Ajouter une tâche")))
                ],
              )),
              PopupMenuItem(
                  child: Row(
                children: [
                  Icon(Icons.star, color: Charter.red),
                  SizedBox(
                    // sized box with width 10
                    width: 10,
                  ),
                  Text("Agenda")
                ],
              )),
            ]
        // value: 1,
        // row has two child icon and text.
        // child:
        // ),
        );
    // GestureDetector(
    //     onTap: () {
    //       // reminders.add(_value);
    //     },
    //     child: ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           backgroundColor: Colors.transparent,
    //         ),
    //         onPressed: () {},
    //         child: Icon(Icons.add_circle_outline)))
  }
}
