import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Reminder {
  String userID;

  //!TODO Changer l'id !
  final int id = 1;

  String? description;
  String? recurrence;
  DateTime? reminder;
  String title;
  //which is equivalent to subject property of [Appointment].
  DateTime startDate;
  // which is equivalent to start time property of [Appointment].
  DateTime endDate;
  //which is equivalent to end time property of [Appointment].
  String background;
  //which is equivalent to color property of [Appointment].
  bool isAllDay;
  //which is equivalent to isAllDay property of [Appointment].

  Reminder(
      {required this.userID,
      required this.title,
      required this.startDate,
      required this.endDate,
      this.description,
      this.recurrence,
      this.reminder,
      required this.background,
      this.isAllDay = false});
}
