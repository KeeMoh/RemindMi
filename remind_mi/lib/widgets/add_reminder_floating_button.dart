import 'package:flutter/material.dart';
import 'package:remind_mi/pages/form_page.dart';
import 'package:remind_mi/utils/charter.dart';

class AddReminderFloatingButton extends StatelessWidget {
  // final Map<String, dynamic>? data;
  const AddReminderFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Charter.secondarycolor,
      foregroundColor: Charter.primarycolor,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const FormPage()),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
