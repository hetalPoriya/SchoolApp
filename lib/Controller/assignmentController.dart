import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:school_app/Controller/teacherMarkAttendanceController.dart';
import 'package:school_app/Model/teacherAssignmentModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class AssignmentController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var past_assignments = [].obs;
  var submitted_assignments = [].obs;
  var pending_assignments = [].obs;
  var checked_assignments = [].obs;
  var unchecked_assignments = [].obs;
  var all_assignments = [].obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  var teacherMarkAttendanceController = Get.put(TeacherMarkAttendanceController());


  Future getStuAssignment() async {
    try{
      isLoading(true);
      log("Inside Assignment Controller");
      ToAssignmentModel toAssignmentModel = ToAssignmentModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(assignmentModelToJson(toAssignmentModel), "student_assignments");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var assignment_details = assignmentModelFromJson(response);
        status = RxString(assignment_details.status);
        error(assignment_details.error);
        past_assignments(assignment_details.pastAssignments);
        submitted_assignments(assignment_details.submittedAssignments);
        pending_assignments(assignment_details.pendingAssignments);
        pending_assignments.forEach((item) {
          log('Subject Name: ${item.subjectName}');
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

  Future getTeacherAssignment() async {
    try{
      isLoading(true);
      log("Inside Teacher Assignment Controller");
      ToTeacherAssignmentModel toTeacherAssignmentModel = ToTeacherAssignmentModel(teacherId: loginController.teacherId.value);
      var response = await NetworkHandler.post(teacherAssignmentModelToJson(toTeacherAssignmentModel), "teacher_assignments");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var assignment_details = teacherAssignmentModelFromJson(response);
        status = RxString(assignment_details.status);
        error(assignment_details.error);
        checked_assignments(assignment_details.checkedAssignments);
        unchecked_assignments(assignment_details.uncheckedAssignments);
        all_assignments(assignment_details.allUploadedAssignments);
        checked_assignments.forEach((item) {
          log('assignment_title: ${item.assignmentTitle}');
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

  Future createTeacherAssignment({required String title,required String description,String? link,String? date,String? expireDate,String? activeStatus,String? path,String? file,bool? isImage}) async {
    try{
      isLoading(true);
      log("Inside Teacher Assignment Controller");

      log('tilte ${title}');
      log('tilte ${path}');
      log('tilte ${file}');
      var response = await NetworkHandler.post(FormData.fromMap({
        'teacher_id':loginController.teacherId.value,
        'title':title ?? '',
        'class_id':teacherMarkAttendanceController.classId.value ?? '',
        'subject_id':teacherMarkAttendanceController.subjectId.value ?? '',
        'section_id':teacherMarkAttendanceController.sectionId.value ?? '',
        'link':link ?? '',
        'description':description ?? '',
        'schedule_date':date ?? '',
        'expire_date':expireDate ?? '',
        if(isImage == true && path.toString().isNotEmpty) 'media': await MultipartFile.fromFile(path.toString(),
            filename: file),
        if(isImage == false && path.toString().isNotEmpty) 'video':await MultipartFile.fromFile(path.toString(),
      filename: file),
        'status':activeStatus ?? 1,
      }), "create_assignment");
      var data = json.decode(response);
      //log(data);

      if(data["error"] == 1){
        Get.back();
      }
      else{
        error(data["error"]);
        status(data["status"]!);
      }
    }finally{
      isLoading(false);
    }
  }


}