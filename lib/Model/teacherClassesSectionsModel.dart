import 'dart:convert';

TeacherClassesSectionsModel teacherClassesSectionsModelFromJson(String str) => TeacherClassesSectionsModel.fromJson(json.decode(str));

String teacherClassesSectionsModelToJson(ToTeacherClassesSectionsModel data) => json.encode(data.toJson());

class ToTeacherClassesSectionsModel {
  ToTeacherClassesSectionsModel({
    required this.teacher_id,
  });
  int teacher_id;
  Map<String, dynamic> toJson() => {
    "teacher_id": teacher_id,
  };
}



class TeacherClassesSectionsModel {
  int? error;
  String? status;
  List<ClassesSection>? classesSections;

  TeacherClassesSectionsModel({
    this.error,
    this.status,
    this.classesSections,
  });

  factory TeacherClassesSectionsModel.fromJson(Map<String, dynamic> json) => TeacherClassesSectionsModel(
    error: json["error"],
    status: json["status"],
    classesSections: json["classes_sections"] == null ? [] : List<ClassesSection>.from(json["classes_sections"]!.map((x) => ClassesSection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "classes_sections": classesSections == null ? [] : List<dynamic>.from(classesSections!.map((x) => x.toJson())),
  };
}

class ClassesSection {
  int? classId;
  String? className;
  int? sectionId;
  String? sectionName;

  ClassesSection({
    this.classId,
    this.className,
    this.sectionId,
    this.sectionName,
  });

  factory ClassesSection.fromJson(Map<String, dynamic> json) => ClassesSection(
    classId: json["class_id"],
    className: json["class_name"],
    sectionId: json["section_id"],
    sectionName: json["section_name"],
  );

  Map<String, dynamic> toJson() => {
    "class_id": classId,
    "class_name": className,
    "section_id": sectionId,
    "section_name": sectionName,
  };
}