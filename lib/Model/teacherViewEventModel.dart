// To parse this JSON data, do
//
//     final teacherViewEventModel = teacherViewEventModelFromJson(jsonString);

import 'dart:convert';

TeacherViewEventModel teacherViewEventModelFromJson(String str) =>
    TeacherViewEventModel.fromJson(json.decode(str));

String teacherViewEventModelToJson(TeacherViewEventModel data) =>
    json.encode(data.toJson());
String toTeacherAddEventModelToJson(ToTeacherAddEventModel data) =>
    json.encode(data.toJson());

class ToTeacherAddEventModel {
  ToTeacherAddEventModel({
    required this.teacherId,
    required this.title,
    required this.description,
    required this.eventDate,
  });
  int teacherId;
  String title;
  String description;
  String eventDate;
  Map<String, dynamic> toJson() => {
        "teacher_id": teacherId,
        "title": title,
        "description": description,
        "event_date": eventDate,
      };
}

class TeacherViewEventModel {
  int? error;
  String? status;
  List<CalenderEvent>? calenderEvents;

  TeacherViewEventModel({
    this.error,
    this.status,
    this.calenderEvents,
  });

  factory TeacherViewEventModel.fromJson(Map<String, dynamic> json) =>
      TeacherViewEventModel(
        error: json["error"],
        status: json["status"],
        calenderEvents: json["calender_events"] == null
            ? []
            : List<CalenderEvent>.from(
                json["calender_events"]!.map((x) => CalenderEvent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "status": status,
        "calender_events": calenderEvents == null
            ? []
            : List<dynamic>.from(calenderEvents!.map((x) => x.toJson())),
      };
}

class CalenderEvent {
  String? title;
  String? description;
  DateTime? eventDate;

  CalenderEvent({
    this.title,
    this.description,
    this.eventDate,
  });

  factory CalenderEvent.fromJson(Map<String, dynamic> json) => CalenderEvent(
        title: json["title"],
        description: json["description"],
        eventDate: json["event_date"] == null
            ? null
            : DateTime.parse(json["event_date"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "event_date":
            "${eventDate!.year.toString().padLeft(4, '0')}-${eventDate!.month.toString().padLeft(2, '0')}-${eventDate!.day.toString().padLeft(2, '0')}",
      };
}