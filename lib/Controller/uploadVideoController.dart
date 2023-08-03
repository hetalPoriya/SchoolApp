import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/Model/getSubjectStudentClassModel.dart';
import 'package:school_app/Model/getTeacherClassesModel.dart';
import 'package:school_app/Model/getTeacherModel.dart';
import 'package:school_app/Model/uploadVideoModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class UploadVideoController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var classes = [].obs;
  var subjects = [].obs;
  var students = [].obs;
  var isLoading = false.obs;
  var isSubjectLoading = false.obs;
  var isUploadLoading = false.obs;
  var isSubjectVisible = false.obs;
  var loginController = Get.put(LoginController());
  var classId = 0.obs;
  var subjectId = 0.obs;
  var studentId = [].obs;
  TextEditingController videoUrlController = TextEditingController();
  TextEditingController videoDescController = TextEditingController();

  Future getClass() async {
    try{
      isLoading(true);
      log("Inside Get classes Controller");
      ToGetTeacherClassesModel toGetTeacherClassesModel = ToGetTeacherClassesModel(teacher_id: loginController.teacherId.value);
      var response = await NetworkHandler.post(getTeacherClassesModelToJson(toGetTeacherClassesModel), "get_teacher_classes");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var get_class_details = getTeacherClassesModelFromJson(response);
        status = RxString(get_class_details.status);
        error(get_class_details.error);
        classes(get_class_details.classes);
        classes.forEach((item) {
          log('class Name: ${item.className}');
        });
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      isLoading(false);
    }
  }
  Future getSubjectStudent() async {
    try{
      isSubjectLoading(true);
      log("Inside Get subject student Controller");
      ToGetSubjectStudentClassModel toGetSubjectStudentClassModel = ToGetSubjectStudentClassModel(class_id: classId.value);
      var response = await NetworkHandler.post(getSubjectStudentClassModelToJson(toGetSubjectStudentClassModel), "get_subject_student_by_class");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var get_details = getSubjectStudentClassModelFromJson(response);
        status = RxString(get_details.status);
        error(get_details.error);
        subjects(get_details.subjects);
        students(get_details.students);
        isSubjectVisible(true);
        subjects.forEach((item) {
          log('subject Name: ${item.subjectName}');
        });
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      isSubjectLoading(false);
    }
  }
  Future uploadVideo() async {
    try{
      isUploadLoading(true);
      log("Inside Upload video Controller");
      ToUploadVideoModel toUploadVideoModel = ToUploadVideoModel(studentId: studentId, teacherId: loginController.teacherId.value, classId: classId.value, subjectId: subjectId.value, link: videoUrlController.text, description: videoDescController.text);
      var response = await NetworkHandler.post(uploadVideoModelToJson(toUploadVideoModel), "upload_video");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var get_details = uploadVideoModelFromJson(response);
        status = RxString(get_details.status);
        error(get_details.error);

      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isUploadLoading(false);
      videoUrlController.clear();
      videoDescController.clear();
    }
  }
}