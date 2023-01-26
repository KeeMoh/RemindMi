import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  DocumentReference? ref;
  String title;
  DateTime startDate;
  DateTime endDate;
  String? description;
  DateTime? reminder;
  String? recurrence;
  String? background;
  bool isAllDay;

  Reminder(
      {this.ref,
      required this.title,
      required this.startDate,
      required this.endDate,
      this.description,
      this.reminder,
      this.recurrence,
      required this.background,
      this.isAllDay = false});

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'reminder': reminder,
        'recurrence': recurrence,
        'background': background,
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
        background: json['background'],
        // background: json['background'],
        isAllDay: json['isAllDay'],
      );

  void delete() {
    ref?.delete();
  }
}
