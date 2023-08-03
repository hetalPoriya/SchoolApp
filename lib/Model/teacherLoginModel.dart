// To parse this JSON data, do
//
//     final teacherLoginModel = teacherLoginModelFromJson(jsonString);

import 'dart:convert';

TeacherLoginModel teacherLoginModelFromJson(String str) => TeacherLoginModel.fromJson(json.decode(str));

String teacherLoginModelToJson(TeacherLoginModel data) => json.encode(data.toJson());

class TeacherLoginModel {
  Token? token;
  int? error;
  String? status;
  TeacherDetails? details;
  String? siblingStatus;

  TeacherLoginModel({
    this.token,
    this.error,
    this.status,
    this.details,
    this.siblingStatus,
  });

  factory TeacherLoginModel.fromJson(Map<String, dynamic> json) => TeacherLoginModel(
    token: json["token"] == null ? null : Token.fromJson(json["token"]),
    error: json["error"],
    status: json["status"],
    details: json["details"] == null ? null : TeacherDetails.fromJson(json["details"]),
    siblingStatus: json["sibling_status"],
  );

  Map<String, dynamic> toJson() => {
    "token": token?.toJson(),
    "error": error,
    "status": status,
    "details": details?.toJson(),
    "sibling_status": siblingStatus,
  };
}

class TeacherDetails {
  int? teacherId;
  String? teacherName;
  String? email;
  int? classId;
  String? className;
  String? sectionName;
  String? gender;
  DateTime? dob;
  String? contactNo;
  String? picture;

  TeacherDetails({
    this.teacherId,
    this.teacherName,
    this.email,
    this.classId,
    this.className,
    this.sectionName,
    this.gender,
    this.dob,
    this.contactNo,
    this.picture,
  });

  factory TeacherDetails.fromJson(Map<String, dynamic> json) => TeacherDetails(
    teacherId: json["teacher_id"],
    teacherName: json["teacher_name"],
    email: json["email"],
    classId: json["class_id"],
    className: json["class_name"],
    sectionName: json["section_name"],
    gender: json["gender"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    contactNo: json["contact_no"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "teacher_id": teacherId,
    "teacher_name": teacherName,
    "email": email,
    "class_id": classId,
    "class_name": className,
    "section_name": sectionName,
    "gender": gender,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "contact_no": contactNo,
    "picture": picture,
  };
}

class Token {
  AccessToken? accessToken;
  String? plainTextToken;

  Token({
    this.accessToken,
    this.plainTextToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    accessToken: json["accessToken"] == null ? null : AccessToken.fromJson(json["accessToken"]),
    plainTextToken: json["plainTextToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken?.toJson(),
    "plainTextToken": plainTextToken,
  };
}

class AccessToken {
  String? name;
  List<String>? abilities;
  int? tokenableId;
  String? tokenableType;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  AccessToken({
    this.name,
    this.abilities,
    this.tokenableId,
    this.tokenableType,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
    name: json["name"],
    abilities: json["abilities"] == null ? [] : List<String>.from(json["abilities"]!.map((x) => x)),
    tokenableId: json["tokenable_id"],
    tokenableType: json["tokenable_type"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "abilities": abilities == null ? [] : List<dynamic>.from(abilities!.map((x) => x)),
    "tokenable_id": tokenableId,
    "tokenable_type": tokenableType,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}