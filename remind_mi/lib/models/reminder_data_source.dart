import 'package:flutter/animation.dart';
import 'package:remind_mi/models/reminder.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class ReminderDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  ReminderDataSource(List<Reminder> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getReminderData(index).startDate;
  }

  @override
  DateTime getEndTime(int index) {
    return _getReminderData(index).endDate;
  }

  @override
  String getSubject(int index) {
    return _getReminderData(index).title;
  }

  // @override
  // Color getColor(int index) {
  //   return _getReminderData(index).background;
  // }

  @override
  bool isAllDay(int index) {
    return _getReminderData(index).isAllDay;
  }

  Reminder _getReminderData(int index) {
    final dynamic reminder = appointments![index];
    late final Reminder reminderData;
    if (reminder is Reminder) {
      reminderData = reminder;
    }

    return reminderData;
  }
}
