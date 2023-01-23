// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:remind_mi/models/reminder.dart';

// class ReminderList {
//   static List<Reminder> reminders = [];

//   void addReminder(String title, DateTime startDate, DateTime endDate,
//       [String? description, bool? allDay]) {
//     String userID = FirebaseAuth.instance.currentUser!.uid;
//     //TODO Changer pour autoIncrementation !
//     int id = ReminderList.reminders.length + 1;
//     reminders.add(Reminder(
//         description: description,
//         title: title,
//         startDate: startDate,
//         endDate: startDate.add(Duration(hours: 2)),
//         userID: userID,
//         id: id));
//   }

//   void deleteReminder(Reminder reminder) {
//     reminders.remove(reminder);
//   }
// }
