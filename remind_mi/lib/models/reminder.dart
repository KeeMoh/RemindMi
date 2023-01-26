import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Reminder {
  String? description;
  DateTime? reminder;
  String? recurrence;
  String? color;
  String title;
  //which is equivalent to subject property of [Appointment].
  DateTime startDate;
  // which is equivalent to start time property of [Appointment].
  DateTime endDate;
  //which is equivalent to end time property of [Appointment].
  // Color background;
  //which is equivalent to color property of [Appointment].
  bool isAllDay;
  //which is equivalent to isAllDay property of [Appointment].

  Reminder(
      {required this.title,
      required this.startDate,
      required this.endDate,
      this.description,
      this.reminder,
      this.recurrence,
      this.color,
      // this.background = const Color(0xFF0F8644),
      this.isAllDay = false});

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'reminder': reminder,
        'recurrence': recurrence,
        'color': color,
        // 'background': background,
        'isAllDay': isAllDay,
      };

  static Reminder fromJson(Map<String, dynamic> json) => Reminder(
        title: json['title'],
        description: json['description'],
        startDate: (json['startDate'] as Timestamp).toDate(),
        endDate: (json['endDate'] as Timestamp).toDate(),
        reminder: (json['reminder'] as Timestamp).toDate(),
        recurrence: json['recurrence'],
        color: json['color'],
        // background: json['background'],
        isAllDay: json['isAllDay'],
      );
}
