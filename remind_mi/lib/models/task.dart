class Event {
  String userID;
  int id;
  String title;
  String? description;
  DateTime startDate;
  DateTime endDate;
  bool allDay;
  DateTime? reminder;

  Event(this.userID, this.id, this.title, this.startDate, this.endDate,
      this.allDay);
}
