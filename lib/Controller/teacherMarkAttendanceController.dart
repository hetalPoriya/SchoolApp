import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_app/Model/assesmentCertModel.dart';
import 'package:school_app/Model/getSubjectByClass.dart';
import 'package:school_app/Model/markAttendanceModel.dart';
import 'package:school_app/Model/stuCompMsgModel.dart';
import 'package:school_app/Model/studentsByClassSectionModel.dart';
import 'package:school_app/Model/teacherClassesSectionsModel.dart';
import 'package:school_app/Model/teacherViewAttendanceModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class TeacherMarkAttendanceController extends GetxController {
  var error = 0.obs;
  var status = ''.obs;

  var classesSections = [].obs;
  var subject = [].obs;

  ClassesSection? classValue;
  ClassesSection? sectionValue;
  SubjectByClass? subjectValue;


  var students = [].obs;
  var studentVisible = false.obs;
  var isLoading = false.obs;
  var isMsgSent = false.obs;
  var viewAttendance = false.obs;

  var dayclassId = 0.obs;
  var classId = 0.obs;
  var sectionId = 0.obs;
  var subjectId = 0.obs;

  RxString className = ' '.obs;
  RxString sectionName = ''.obs;
  RxString subjectName = ''.obs;

  var studentId = [].obs;
  var vStudentId = 0.obs;
  var isStudentLoading = false.obs;
  var attendance = [].obs;
  var attendanceMonth = 0.obs;
  TextEditingController attendanceDate = TextEditingController();
  var loginController = Get.put(LoginController());

  Future getClassesSections() async {
    className.value = '';
    sectionName.value = '';
    classId.value = 0;
    sectionId.value = 0;

    try {
      isLoading(true);
      log("Inside TeacherClassesSections Controller");
      ToTeacherClassesSectionsModel toTeacherClassesSectionsModel =
          ToTeacherClassesSectionsModel(
              teacher_id: loginController.teacherId.value);
      var response = await NetworkHandler.post(
          teacherClassesSectionsModelToJson(toTeacherClassesSectionsModel),
          "get_teacher_classes_sections");
      var data = json.decode(response);
      //log(data);

      if (data["error"] == 1) {
        var data_details = teacherClassesSectionsModelFromJson(response);
        status = RxString(data_details.status ?? '');
        error(data_details.error);

        classesSections(data_details.classesSections);
        classValue = classesSections.first;
        sectionValue = classesSections.first;
        classId.value = classValue?.classId ?? 0;
        sectionId.value = classValue?.sectionId ?? 0;
        getSubjectByClassSection();

      } else {
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
    }
  }

  Future getStudentsByClassSection() async {
    try {
      isStudentLoading(true);
      log("Inside StudentsByClassSection Controller");
      ToStudentsByClassSectionModel toStudentsByClassSectionModel =
          ToStudentsByClassSectionModel(
              class_id: classId.value, section_id: sectionId.value);
      var response = await NetworkHandler.post(
          studentsByClassSectionModelToJson(toStudentsByClassSectionModel),
          "get_students_by_class_section");
      var data = json.decode(response);
      //log(data);

      if (data["error"] == 1) {
        var data_details = studentsByClassSectionModelFromJson(response);
        status = RxString(data_details.status);
        error(data_details.error);
        students(data_details.students);
        studentVisible(true);
        students.forEach((item) {
          log('studentName: ${item.studentName}');
        });
      } else {
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isStudentLoading(false);
    }
  }

  Future getSubjectByClassSection() async {
    try {
      isStudentLoading(true);
      log("Inside getSubjectByClassSection Controller");
      ToSubjectByClassModel toSubjectByClassModel =
          ToSubjectByClassModel(
              classId: classId.value);
      var response = await NetworkHandler.post(
          toSubjectByClassModelToJson(toSubjectByClassModel),
          "get_subjects_by_class");
      var data = json.decode(response);
      //log(data);

      if (data["error"] == 1) {
        var data_details = subjectByClasseModelFromJson(response);
        status = RxString(data_details.status.toString());
        error(data_details.error);
        subject(data_details.subjects);
        subjectValue= subject.first;
        subjectId.value = subjectValue?.id ?? 0;
      } else {
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isStudentLoading(false);
    }
  }

  Future teacherMarkAttendance() async {
    try {
      isMsgSent(true);
      log("Inside teacherMarkAttendance Controller");
      ToMarkAttendanceModel toMarkAttendanceModel = ToMarkAttendanceModel(
          teacherId: loginController.teacherId.value,
          classId: classId.value,
          sectionId: sectionId.value,
          studentId: studentId,
          attendanceDate: attendanceDate.text);
      var response = await NetworkHandler.post(
          markAttendanceModelToJson(toMarkAttendanceModel), "mark_attendance");
      var data = json.decode(response);
      //log(data);

      if (data["error"] == 1) {
        var data_details = stuCompMsgModelFromJson(response);
        status = RxString(data_details.status);
        error(data_details.error);
      } else {
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isMsgSent(false);
      attendanceDate.clear();
    }
  }

  Future teacherViewAttendance() async {
    try {
      isMsgSent(true);
      log("Inside teacherViewAttendance Controller");
      ToTeacherViewAttendanceModel toTeacherViewAttendanceModel =
          ToTeacherViewAttendanceModel(
              classId: classId.value,
              sectionId: sectionId.value,
              attendanceDate: attendanceDate.text);
      var response = await NetworkHandler.post(
          teacherViewAttendanceModelToJson(toTeacherViewAttendanceModel),
          "view_day_wise_attendance");
      var data = json.decode(response);
      //log(data);

      if (data["error"] == 1) {
        var data_details = teacherViewAttendanceModelFromJson(response);
        status = RxString(data_details.status);
        error(data_details.error);
        attendance(data_details.attendance);
        viewAttendance(true);
      } else {
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isMsgSent(false);
      attendanceDate.clear();
    }
  }

  Future teacherViewStuAttendance() async {
    try {
      isMsgSent(true);
      log("Inside teacherViewStuAttendance Controller");
      ToTeacherViewAttendanceModel toTeacherViewAttendanceModel =
          ToTeacherViewAttendanceModel(
              classId: classId.value,
              sectionId: sectionId.value,
              attendanceDate: attendanceDate.text);
      var response = await NetworkHandler.post(
          teacherViewAttendanceModelToJson(toTeacherViewAttendanceModel),
          "view_day_wise_attendance");
      var data = json.decode(response);
      //log(data);

      if (data["error"] == 1) {
        var data_details = teacherViewAttendanceModelFromJson(response);
        status = RxString(data_details.status);
        error(data_details.error);
        attendance(data_details.attendance);
        viewAttendance(true);
      } else {
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isMsgSent(false);
      attendanceDate.clear();
    }
  }
}