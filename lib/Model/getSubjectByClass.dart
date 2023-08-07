// To parse this JSON data, do
//
//     final subjectByClasseModel = subjectByClasseModelFromJson(jsonString);

import 'dart:convert';

SubjectByClasseModel subjectByClasseModelFromJson(String str) => SubjectByClasseModel.fromJson(json.decode(str));

String subjectByClasseModelToJson(SubjectByClasseModel data) => json.encode(data.toJson());

String toSubjectByClassModelToJson(ToSubjectByClassModel data) => json.encode(data.toJson());

class ToSubjectByClassModel {
  ToSubjectByClassModel({
    required this.classId,
  });
  int classId;
  Map<String, dynamic> toJson() => {
    "class_id": classId,
  };
}

class SubjectByClasseModel {
  int? error;
  String? status;
  List<SubjectByClass>? subjects;

  SubjectByClasseModel({
    this.error,
    this.status,
    this.subjects,
  });

  factory SubjectByClasseModel.fromJson(Map<String, dynamic> json) => SubjectByClasseModel(
    error: json["error"],
    status: json["status"],
    subjects: json["subjects"] == null ? [] : List<SubjectByClass>.from(json["subjects"]!.map((x) => SubjectByClass.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
  };
}

class SubjectByClass {
  int? id;
  String? name;
  int? classId;
  int? branchId;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubjectByClass({
    this.id,
    this.name,
    this.classId,
    this.branchId,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  factory SubjectByClass.fromJson(Map<String, dynamic> json) => SubjectByClass(
    id: json["id"],
    name: json["name"],
    classId: json["class_id"],
    branchId: json["branch_id"],
    slug: json["slug"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "class_id": classId,
    "branch_id": branchId,
    "slug": slug,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}