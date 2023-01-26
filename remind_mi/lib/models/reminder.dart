import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  DocumentReference? ref;
  String title;
  DateTime startDate;
  DateTime endDate;
  String? description;
  DateTime? reminder;
  String? recurrence;
  String? color;
  bool isAllDay;

  Reminder(
      {this.ref,
      required this.title,
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

  static Reminder fromJson(Map<String, dynamic> json,
          {required DocumentReference ref}) =>
      Reminder(
        ref: ref,
        title: json['title'],
        description: json['description'],
        startDate: DateTime.parse(json['startDate'].toDate().toString()),
        endDate: DateTime.parse(json['endDate'].toDate().toString()),
        reminder: json['reminder'] == null
            ? null
            : DateTime.parse(json['reminder'].toDate().toString()),
        recurrence: json['recurrence'],
        color: json['color'],
        // background: json['background'],
        isAllDay: json['isAllDay'],
      );

  void delete() {
    ref?.delete();
  }

}
