import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:remind_mi/pages/form_page.dart';
import 'package:remind_mi/utils/charter.dart';

class AddReminderFloatingButton extends StatelessWidget {
  const AddReminderFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Charter.secondarycolor,
      foregroundColor: Charter.primarycolor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FormPage(selectedDate: DateTime.now())),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
